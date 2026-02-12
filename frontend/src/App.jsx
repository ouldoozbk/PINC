import React, { useState, useEffect, useRef, useCallback } from 'react'

const API = '' // proxied via vite

// ─── Helpers ──────────────────────────────────────────────────────────────

function scoreColor(v) {
  if (v >= 0.85) return 'green'
  if (v >= 0.6) return 'yellow'
  return 'red'
}

function pretty(obj) {
  return JSON.stringify(obj, null, 2)
}

// ─── Score Bar ────────────────────────────────────────────────────────────

function ScoreBar({ label, value }) {
  const pct = Math.round(value * 100)
  return (
    <div className="score-bar-container">
      <div className="score-label">
        <span>{label}</span>
        <span style={{ fontWeight: 600, color: `var(--${scoreColor(value)})` }}>{pct}%</span>
      </div>
      <div className="score-bar">
        <div className={`score-fill ${scoreColor(value)}`} style={{ width: `${pct}%` }} />
      </div>
    </div>
  )
}

// ─── Pipeline Flow ────────────────────────────────────────────────────────

const STAGES = [
  { key: 'intent', label: 'Intent Input' },
  { key: 'parsing_intent', label: 'Parse Intent' },
  { key: 'generating', label: 'LLM Generate' },
  { key: 'vrf_a', label: 'VRF A' },
  { key: 'vrf_a5', label: 'VRF A.5' },
  { key: 'vrf_b', label: 'VRF B' },
  { key: 'done', label: 'Done' },
]

function PipelineFlow({ currentStage, status }) {
  const idx = STAGES.findIndex(s => s.key === currentStage)
  return (
    <div className="pipeline-flow">
      {STAGES.map((s, i) => {
        let cls = 'pipeline-step'
        if (i === idx) cls += status === 'failed' && i === STAGES.length - 1 ? ' failed' : ' active'
        else if (i < idx) cls += ' done'

        const stepNum = i + 1
        return (
          <React.Fragment key={s.key}>
            {i > 0 && (
              <span className="pipeline-arrow">
                <svg width="20" height="12" viewBox="0 0 20 12" fill="none">
                  <path d="M0 6h16m0 0l-4-4.5M16 6l-4 4.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </span>
            )}
            <span className={cls}>
              <span className="pipeline-step-num">{stepNum}</span>
              {s.label}
            </span>
          </React.Fragment>
        )
      })}
    </div>
  )
}

// ─── Tab: Run Full Pipeline ───────────────────────────────────────────────

function RunPipelineTab({ form, setForm, pipelineState, setPipelineState }) {
  const polling = useRef(null)

  const intent = form.intent
  const yangModel = form.yangModel
  const yangData = form.yangData
  const apiKey = form.apiKey
  const provider = form.provider
  const maxAttempts = form.maxAttempts
  const state = pipelineState

  const setField = (key, val) => setForm(prev => ({ ...prev, [key]: val }))

  const start = async () => {
    const res = await fetch(`${API}/api/run-pipeline`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ intent, yang_model: yangModel, yang_data: yangData, api_key: apiKey, provider, max_attempts: maxAttempts }),
    })
    if (!res.ok) {
      const err = await res.json()
      alert(err.error || 'Failed to start pipeline')
      return
    }
    // Start polling
    polling.current = setInterval(async () => {
      try {
        const r = await fetch(`${API}/api/pipeline-status`)
        const d = await r.json()
        setPipelineState(d)
        if (!d.running) clearInterval(polling.current)
      } catch { /* ignore */ }
    }, 1500)
  }

  const stop = async () => {
    try {
      await fetch(`${API}/api/stop-pipeline`, { method: 'POST' })
    } catch { /* ignore */ }
  }

  useEffect(() => () => clearInterval(polling.current), [])

  const running = state?.running
  const stage = state?.stage || 'intent'
  const status = state?.status || 'idle'

  return (
    <div>
      <PipelineFlow currentStage={stage} status={status} />

      <div className="grid-2">
        {/* Left: Inputs */}
        <div>
          <div className="card">
            <div className="card-title">Pipeline Inputs</div>

            <div className="form-group">
              <label>Network Intent *</label>
              <textarea
                value={intent}
                onChange={e => setField('intent', e.target.value)}
                placeholder="e.g. Create a P4 program for basic Ethernet switch with source MAC learning and destination MAC forwarding"
                rows={3}
              />
            </div>

            <div className="inline-row">
              <div className="form-group">
                <label>LLM Provider</label>
                <select value={provider} onChange={e => setField('provider', e.target.value)}>
                  <option value="replicate">Replicate (Llama 3)</option>
                  <option value="openai">OpenAI (GPT-4)</option>
                </select>
              </div>
              <div className="form-group">
                <label>Max Attempts</label>
                <input type="number" value={maxAttempts} onChange={e => setField('maxAttempts', e.target.value)} min={1} max={20} />
              </div>
            </div>

            <div className="form-group">
              <label>API Key *</label>
              <input type="password" value={apiKey} onChange={e => setField('apiKey', e.target.value)} placeholder={provider === 'openai' ? 'sk-...' : 'r8_...'} />
            </div>

            <div className="form-group">
              <label>YANG Model (optional)</label>
              <textarea value={yangModel} onChange={e => setField('yangModel', e.target.value)} placeholder="Paste YANG schema here..." rows={3} />
            </div>

            <div className="form-group">
              <label>YANG Data / JSON Config (optional)</label>
              <textarea value={yangData} onChange={e => setField('yangData', e.target.value)} placeholder='Paste JSON configuration here...' rows={3} />
            </div>

            <div style={{ display: 'flex', gap: 10, alignItems: 'center' }}>
              <button className="btn btn-primary" onClick={start} disabled={running || !intent || !apiKey}>
                {running ? <><span className="spinner" /> Running...</> : 'Run Pipeline'}
              </button>
              {running && (
                <button className="btn" onClick={stop} style={{ background: '#dc2626', color: '#fff', border: 'none' }}>
                  Stop
                </button>
              )}
            </div>
          </div>
        </div>

        {/* Right: Results */}
        <div>
          {/* VRF A */}
          {state?.vrf_a_result && (
            <div className="card">
              <div className="card-title">VRF A — Compilation</div>
              {state.vrf_a_result.success ? (
                <span className="badge badge-success">Compiled</span>
              ) : (
                <span className="badge badge-error">Failed</span>
              )}
              {state.vrf_a_result.errors && (
                <pre className="json-viewer" style={{ marginTop: 10, maxHeight: 150 }}>{state.vrf_a_result.errors}</pre>
              )}
            </div>
          )}

          {/* VRF A.5 */}
          {state?.vrf_a5_result && (
            <div className="card">
              <div className="card-title">VRF A.5 — Intent Validation</div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 12 }}>
                {state.vrf_a5_result.passed ? (
                  <span className="badge badge-success">Passed</span>
                ) : (
                  <span className="badge badge-error">Failed</span>
                )}
                <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>
                  Attempt {state.attempt} / {state.max_attempts}
                </span>
              </div>
              <ScoreBar label="Overall" value={state.vrf_a5_result.match_score} />
              {state.vrf_a5_result.detailed_scores && (
                <>
                  <ScoreBar label="Required Behaviors" value={state.vrf_a5_result.detailed_scores.required_behaviors || 0} />
                  <ScoreBar label="Headers" value={state.vrf_a5_result.detailed_scores.headers || 0} />
                  <ScoreBar label="Control Blocks" value={state.vrf_a5_result.detailed_scores.control_blocks || 0} />
                  <ScoreBar label="Prohibited Check" value={state.vrf_a5_result.detailed_scores.prohibited_check || 0} />
                </>
              )}
            </div>
          )}

          {/* VRF B */}
          {state?.vrf_b_result && (
            <div className="card">
              <div className="card-title">VRF B — Functional Testing</div>
              {state.vrf_b_result.skipped ? (
                <span className="badge badge-info">Skipped</span>
              ) : state.vrf_b_result.success ? (
                <span className="badge badge-success">All Tests Passed</span>
              ) : (
                <span className="badge badge-error">Tests Failed</span>
              )}
              {state.vrf_b_result.error && (
                <p style={{ marginTop: 8, fontSize: '0.82rem', color: 'var(--text-muted)' }}>{state.vrf_b_result.error}</p>
              )}
              {state.vrf_b_result.stdout && (
                <pre className="code-viewer" style={{ marginTop: 10, maxHeight: 200 }}>{state.vrf_b_result.stdout}</pre>
              )}
              {state.vrf_b_result.stderr && (
                <pre className="code-viewer" style={{ marginTop: 6, maxHeight: 120, color: 'var(--yellow)' }}>{state.vrf_b_result.stderr}</pre>
              )}
            </div>
          )}

          {/* Status */}
          {state && (
            <div className="card">
              <div className="card-title">Status</div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
                {status === 'running' && <span className="spinner" />}
                <span className={`badge ${status === 'success' ? 'badge-success' : status === 'failed' ? 'badge-error' : 'badge-info'}`}>
                  {status}
                </span>
                {state.attempt > 0 && (
                  <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>
                    Attempt {state.attempt} / {state.max_attempts}
                  </span>
                )}
              </div>
            </div>
          )}

          {/* Generated P4 Code */}
          {state?.p4_code && (
            <div className="card">
              <div className="card-title">Generated P4 Code</div>
              <pre className="code-viewer">{state.p4_code}</pre>
            </div>
          )}

          {/* Logs */}
          {state?.logs?.length > 0 && (
            <div className="card">
              <div className="card-title">Pipeline Logs</div>
              <LogPanel logs={state.logs} />
            </div>
          )}
        </div>
      </div>

      {/* JSON panels */}
      {(state?.expected_behavior || state?.actual_behavior) && (
        <div className="grid-2" style={{ marginTop: 8 }}>
          {state.expected_behavior && (
            <div className="card">
              <div className="card-title">Expected Behavior (VRF A.5)</div>
              <pre className="json-viewer">{pretty(state.expected_behavior)}</pre>
            </div>
          )}
          {state.actual_behavior && (
            <div className="card">
              <div className="card-title">Actual Behavior (VRF A.5)</div>
              <pre className="json-viewer">{pretty(state.actual_behavior)}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Tab: VRF A (Compile) ─────────────────────────────────────────────────

function CompileTab({ compileState, setCompileState }) {
  const code = compileState.code
  const result = compileState.result
  const [loading, setLoading] = useState(false)

  const setCode = (v) => setCompileState(prev => ({ ...prev, code: v }))
  const setResult = (v) => setCompileState(prev => ({ ...prev, result: v }))

  const compile = async () => {
    setLoading(true)
    setResult(null)
    try {
      const res = await fetch(`${API}/api/compile`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ p4_code: code }),
      })
      setResult(await res.json())
    } finally {
      setLoading(false)
    }
  }

  return (
    <div>
      <div className="card">
        <div className="card-title">VRF A — P4 Compilation</div>
        <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: 12 }}>
          Paste P4-16 code below to clean it up and compile via Docker p4c.
        </p>
        <div className="form-group">
          <label>P4 Source Code</label>
          <textarea className="tall" value={code} onChange={e => setCode(e.target.value)} placeholder="#include <core.p4>..." />
        </div>
        <button className="btn btn-primary" onClick={compile} disabled={loading || !code}>
          {loading ? <><span className="spinner" /> Compiling...</> : 'Compile'}
        </button>
      </div>

      {result && (
        <div className="grid-2">
          <div className="card">
            <div className="card-title">Result</div>
            {result.success ? (
              <span className="badge badge-success">Compilation Successful</span>
            ) : (
              <span className="badge badge-error">Compilation Failed</span>
            )}
            {result.errors && <pre className="json-viewer" style={{ marginTop: 12 }}>{result.errors}</pre>}
          </div>
          {result.cleaned_code && (
            <div className="card">
              <div className="card-title">Cleaned P4 Code</div>
              <pre className="code-viewer">{result.cleaned_code}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Tab: VRF A.5 (Intent) ───────────────────────────────────────────────

function IntentTab({ intentState, setIntentState }) {
  const { intent, expectedJson, actualJson, p4Code, parseResult, extractResult, compareResult, validateResult } = intentState

  const set = (key, val) => setIntentState(prev => ({ ...prev, [key]: val }))
  const setIntent = (v) => set('intent', v)
  const setExpectedJson = (v) => set('expectedJson', v)
  const setActualJson = (v) => set('actualJson', v)
  const setP4Code = (v) => set('p4Code', v)
  const setParseResult = (v) => set('parseResult', v)
  const setExtractResult = (v) => set('extractResult', v)
  const setCompareResult = (v) => set('compareResult', v)
  const setValidateResult = (v) => set('validateResult', v)

  const parseIntent = async () => {
    const res = await fetch(`${API}/api/parse-intent`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ intent }),
    })
    const data = await res.json()
    setParseResult(data.expected_behavior)
    setExpectedJson(pretty(data.expected_behavior))
  }

  const extractBehavior = async () => {
    const res = await fetch(`${API}/api/extract-behavior`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ p4_code: p4Code }),
    })
    const data = await res.json()
    setExtractResult(data.actual_behavior)
    setActualJson(pretty(data.actual_behavior))
  }

  const compare = async () => {
    let exp, act
    try { exp = JSON.parse(expectedJson) } catch { alert('Invalid expected JSON'); return }
    try { act = JSON.parse(actualJson) } catch { alert('Invalid actual JSON'); return }
    const res = await fetch(`${API}/api/compare`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ expected_behavior: exp, actual_behavior: act }),
    })
    setCompareResult(await res.json())
  }

  const validateVrfA5 = async () => {
    let exp = null
    try { exp = expectedJson ? JSON.parse(expectedJson) : null } catch { /* ignore */ }
    const res = await fetch(`${API}/api/validate-intent`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ p4_code: p4Code, expected_behavior: exp }),
    })
    setValidateResult(await res.json())
  }

  return (
    <div>
      {/* Intent → Expected */}
      <div className="card">
        <div className="card-title">Step 1: Parse Intent &rarr; Expected Behavior</div>
        <div className="form-group">
          <label>Network Intent</label>
          <textarea value={intent} onChange={e => setIntent(e.target.value)} placeholder="e.g. Implement a basic Ethernet switch with MAC learning" rows={2} />
        </div>
        <button className="btn btn-primary btn-sm" onClick={parseIntent} disabled={!intent}>Parse Intent</button>
        {parseResult && (
          <pre className="json-viewer" style={{ marginTop: 12 }}>{pretty(parseResult)}</pre>
        )}
      </div>

      {/* P4 Code → Actual */}
      <div className="card">
        <div className="card-title">Step 2: Extract Behavior from P4 Code</div>
        <div className="form-group">
          <label>P4 Source Code</label>
          <textarea className="tall" value={p4Code} onChange={e => setP4Code(e.target.value)} placeholder="#include <core.p4>..." />
        </div>
        <button className="btn btn-primary btn-sm" onClick={extractBehavior} disabled={!p4Code}>Extract Behavior</button>
        {extractResult && (
          <pre className="json-viewer" style={{ marginTop: 12 }}>{pretty(extractResult)}</pre>
        )}
      </div>

      {/* Compare */}
      <div className="card">
        <div className="card-title">Step 3: Compare Expected vs Actual</div>
        <div className="grid-2">
          <div className="form-group">
            <label>Expected Behavior JSON</label>
            <textarea className="tall" value={expectedJson} onChange={e => setExpectedJson(e.target.value)} placeholder='{"required_behaviors": [...], ...}' />
          </div>
          <div className="form-group">
            <label>Actual Behavior JSON</label>
            <textarea className="tall" value={actualJson} onChange={e => setActualJson(e.target.value)} placeholder='{"detected_behaviors": [...], ...}' />
          </div>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <button className="btn btn-primary btn-sm" onClick={compare} disabled={!expectedJson || !actualJson}>Compare JSONs</button>
          <button className="btn btn-secondary btn-sm" onClick={validateVrfA5} disabled={!p4Code}>Run Full VRF A.5</button>
        </div>

        {compareResult && (
          <div style={{ marginTop: 16 }}>
            <ScoreBar label="Overall Match" value={compareResult.match_score} />
            {compareResult.detailed_scores && (
              <>
                <ScoreBar label="Required Behaviors" value={compareResult.detailed_scores.required_behaviors || 0} />
                <ScoreBar label="Headers" value={compareResult.detailed_scores.headers || 0} />
                <ScoreBar label="Control Blocks" value={compareResult.detailed_scores.control_blocks || 0} />
                <ScoreBar label="Prohibited Check" value={compareResult.detailed_scores.prohibited_check || 0} />
              </>
            )}
            {compareResult.feedback && (
              <pre className="json-viewer" style={{ marginTop: 10 }}>{compareResult.feedback}</pre>
            )}
          </div>
        )}

        {validateResult && (
          <div style={{ marginTop: 16 }}>
            <div style={{ marginBottom: 8 }}>
              {validateResult.passed ? (
                <span className="badge badge-success">VRF A.5 Passed</span>
              ) : (
                <span className="badge badge-error">VRF A.5 Failed</span>
              )}
            </div>
            <ScoreBar label="Overall Match" value={validateResult.match_score} />
            {validateResult.detailed_scores && (
              <>
                <ScoreBar label="Required Behaviors" value={validateResult.detailed_scores.required_behaviors || 0} />
                <ScoreBar label="Headers" value={validateResult.detailed_scores.headers || 0} />
                <ScoreBar label="Control Blocks" value={validateResult.detailed_scores.control_blocks || 0} />
                <ScoreBar label="Prohibited Check" value={validateResult.detailed_scores.prohibited_check || 0} />
              </>
            )}
            {validateResult.actual_behavior && (
              <div style={{ marginTop: 12 }}>
                <div className="card-title">Extracted Actual Behavior</div>
                <pre className="json-viewer">{pretty(validateResult.actual_behavior)}</pre>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  )
}

// ─── Tab: VRF B (Functional Testing) ──────────────────────────────────────

function FunctionalTab({ vrfbState, setVrfbState }) {
  const { p4Code, poolStatus, testResult } = vrfbState
  const [loading, setLoading] = useState(false)
  const [poolLoading, setPoolLoading] = useState(false)

  const set = (key, val) => setVrfbState(prev => ({ ...prev, [key]: val }))

  const refreshPool = async () => {
    try {
      const r = await fetch(`${API}/api/vrf-b/status`)
      set('poolStatus', await r.json())
    } catch { /* ignore */ }
  }

  useEffect(() => { refreshPool() }, [])

  const startPool = async () => {
    setPoolLoading(true)
    try {
      const r = await fetch(`${API}/api/vrf-b/start-pool`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: '{}' })
      const data = await r.json()
      if (!r.ok) { alert(data.error || 'Failed to start pool'); return }
      set('poolStatus', data)
    } finally { setPoolLoading(false) }
  }

  const stopPool = async () => {
    setPoolLoading(true)
    try {
      const r = await fetch(`${API}/api/vrf-b/stop-pool`, { method: 'POST' })
      set('poolStatus', await r.json())
    } finally { setPoolLoading(false) }
  }

  const runTest = async () => {
    setLoading(true)
    set('testResult', null)
    try {
      const r = await fetch(`${API}/api/vrf-b/validate`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ p4_code: p4Code }),
      })
      set('testResult', await r.json())
    } catch (e) {
      set('testResult', { success: false, error: e.message })
    } finally {
      setLoading(false)
      refreshPool()
    }
  }

  const poolRunning = poolStatus?.running
  const poolAvail = poolStatus?.available ?? 0
  const poolTotal = poolStatus?.total ?? 0

  return (
    <div>
      {/* Pool Management */}
      <div className="card">
        <div className="card-title">Container Pool</div>
        <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: 12 }}>
          VRF B runs <strong>p4testgen + PTF</strong> inside privileged Docker containers (image: <code style={{ fontFamily: 'var(--mono)', background: 'var(--bg)', padding: '2px 6px', borderRadius: 4 }}>p4_test_suite</code>).
          Start the pool before running tests. The pool is also used by the full pipeline.
        </p>

        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 16 }}>
          <span className={`badge ${poolRunning ? 'badge-success' : 'badge-error'}`}>
            {poolRunning ? 'Running' : 'Stopped'}
          </span>
          {poolRunning && (
            <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>
              {poolAvail} / {poolTotal} workers available
            </span>
          )}
        </div>

        <div style={{ display: 'flex', gap: 10 }}>
          {!poolRunning ? (
            <button className="btn btn-primary btn-sm" onClick={startPool} disabled={poolLoading}>
              {poolLoading ? <><span className="spinner" /> Starting...</> : 'Start Pool'}
            </button>
          ) : (
            <button className="btn btn-secondary btn-sm" onClick={stopPool} disabled={poolLoading}>
              {poolLoading ? <><span className="spinner" /> Stopping...</> : 'Stop Pool'}
            </button>
          )}
          <button className="btn btn-secondary btn-sm" onClick={refreshPool}>Refresh</button>
        </div>

        {!poolRunning && (
          <div style={{ marginTop: 12, padding: 12, background: 'var(--bg-input)', borderRadius: 8, border: '1px solid var(--border)' }}>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.78rem', lineHeight: 1.7 }}>
              <strong>First-time setup:</strong> Build the Docker image from <code style={{ fontFamily: 'var(--mono)', background: 'var(--bg)', padding: '2px 4px', borderRadius: 4 }}>code/server-validation/p4testgen-server/</code>:
            </p>
            <pre className="json-viewer" style={{ marginTop: 6, maxHeight: 60, fontSize: '0.76rem' }}>docker buildx build --tag p4_test_suite . --load</pre>
          </div>
        )}
      </div>

      {/* Run Test */}
      <div className="card">
        <div className="card-title">Run Functional Test</div>
        <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: 12 }}>
          Submit P4-16 code. The worker runs p4testgen (generates up to 10 PTF test cases), compiles with p4c, starts simple_switch_grpc, and executes PTF tests.
        </p>
        <div className="form-group">
          <label>P4 Source Code</label>
          <textarea className="tall" value={p4Code} onChange={e => set('p4Code', e.target.value)} placeholder="#include <core.p4>..." />
        </div>
        <button className="btn btn-primary" onClick={runTest} disabled={loading || !p4Code || !poolRunning}>
          {loading ? <><span className="spinner" /> Running Tests...</> : 'Run VRF B Tests'}
        </button>
        {!poolRunning && p4Code && (
          <span style={{ marginLeft: 12, fontSize: '0.78rem', color: 'var(--yellow)' }}>Start the container pool first</span>
        )}
      </div>

      {/* Results */}
      {testResult && (
        <div className="card">
          <div className="card-title">Test Results</div>
          <div style={{ marginBottom: 12 }}>
            {testResult.success ? (
              <span className="badge badge-success">All Tests Passed</span>
            ) : (
              <span className="badge badge-error">{testResult.error ? 'Error' : 'Tests Failed'}</span>
            )}
            {testResult.returncode != null && (
              <span style={{ marginLeft: 10, fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                Exit code: {testResult.returncode}
              </span>
            )}
          </div>

          {testResult.error && (
            <div style={{ padding: 10, background: 'var(--red-bg)', borderRadius: 8, marginBottom: 12, fontSize: '0.82rem', color: 'var(--red)' }}>
              {testResult.error}
            </div>
          )}

          {testResult.stdout && (
            <div style={{ marginBottom: 12 }}>
              <div className="card-title">stdout</div>
              <pre className="code-viewer" style={{ maxHeight: 300 }}>{testResult.stdout}</pre>
            </div>
          )}

          {testResult.stderr && (
            <div>
              <div className="card-title">stderr</div>
              <pre className="code-viewer" style={{ maxHeight: 200, color: 'var(--yellow)' }}>{testResult.stderr}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Tab: JSON Schemas ────────────────────────────────────────────────────

function SchemasTab() {
  const expectedSchema = {
    intent_id: "intent_abc123",
    timestamp: "2026-02-11T12:00:00Z",
    intent_type: "inferred",
    raw_intent: "Create a P4 program for basic Ethernet switch with MAC learning",
    required_behaviors: [
      {
        behavior_id: "mac_learning",
        description: "Inferred from intent: mac learning",
        components: { table_required: true, table_type: "exact", key_fields: [], action_types: [] }
      },
      {
        behavior_id: "forwarding",
        description: "Inferred from intent: forwarding",
        components: { table_required: true, table_type: "exact", key_fields: [], action_types: [] }
      }
    ],
    headers_required: ["ethernet"],
    control_blocks: {
      ingress: { required: true, must_contain: [] },
      egress: { required: false }
    },
    prohibited_behaviors: [],
    performance_constraints: {}
  }

  const actualSchema = {
    code_id: "code_abc123",
    timestamp: "2026-02-11T12:00:05Z",
    detected_behaviors: [
      {
        behavior_id: "mac_learning_impl",
        evidence: {
          table_name: "mac_learn_table",
          table_type: "exact",
          key_fields: ["hdr.ethernet.srcAddr"],
          actions: ["learn_mac", "NoAction"],
          default_action: "NoAction"
        }
      }
    ],
    headers_defined: ["ethernet_t"],
    control_blocks: { ingress: ["MyIngress"], egress: ["MyEgress"] },
    suspicious_patterns: []
  }

  const comparisonSchema = {
    match_score: 0.875,
    detailed_scores: {
      required_behaviors: 0.5,
      headers: 1.0,
      control_blocks: 1.0,
      prohibited_check: 1.0
    },
    weights: {
      required_behaviors: 0.5,
      headers: 0.15,
      control_blocks: 0.15,
      prohibited_check: 0.2
    },
    thresholds: { pass: 0.85, partial: 0.60, fail: "< 0.60" }
  }

  return (
    <div>
      <div className="grid-2">
        <div className="card">
          <div className="card-title">Expected Behavior JSON (VRF A.5 Input)</div>
          <p style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: 10 }}>
            Generated from user intent via <code>vrf_a5_intent_parser.py</code>
          </p>
          <pre className="json-viewer">{pretty(expectedSchema)}</pre>
        </div>
        <div className="card">
          <div className="card-title">Actual Behavior JSON (VRF A.5 Output)</div>
          <p style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: 10 }}>
            Extracted from P4 code via <code>vrf_a5_behavior_extractor.py</code>
          </p>
          <pre className="json-viewer">{pretty(actualSchema)}</pre>
        </div>
      </div>
      <div className="card">
        <div className="card-title">Comparison / Scoring Schema</div>
        <p style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: 10 }}>
          Computed by <code>vrf_a5_semantic_comparator.py</code>. Weighted score determines pass/partial/fail.
        </p>
        <pre className="json-viewer">{pretty(comparisonSchema)}</pre>
      </div>
    </div>
  )
}

// ─── Log Panel ────────────────────────────────────────────────────────────

function LogPanel({ logs }) {
  const ref = useRef()
  useEffect(() => {
    if (ref.current) ref.current.scrollTop = ref.current.scrollHeight
  }, [logs])
  return (
    <div className="log-panel" ref={ref}>
      {logs.map((l, i) => (
        <div key={i} className="log-entry">
          <span className="log-time">{new Date(l.time).toLocaleTimeString()}</span>
          {l.message}
        </div>
      ))}
    </div>
  )
}

// ─── App ──────────────────────────────────────────────────────────────────

export default function App() {
  const [tab, setTab] = useState('pipeline')

  // ── Lifted state for all tabs so it persists across tab switches ──

  // Run Pipeline tab
  const [pipelineForm, setPipelineForm] = useState({
    intent: '',
    yangModel: '',
    yangData: '',
    maxAttempts: 10,
  })
  const [pipelineState, setPipelineState] = useState(null)

  // Compile tab
  const [compileState, setCompileState] = useState({
    code: '',
    result: null,
  })

  // Intent tab
  const [intentState, setIntentState] = useState({
    intent: '',
    expectedJson: '',
    actualJson: '',
    p4Code: '',
    parseResult: null,
    extractResult: null,
    compareResult: null,
    validateResult: null,
  })

  // VRF B (Functional) tab
  const [vrfbState, setVrfbState] = useState({
    p4Code: '',
    poolStatus: null,
    testResult: null,
  })

  return (
    <div className="app">
      <header>
        <h1><span>PINC</span> — P4 Intent-driven Network Compiler</h1>
        <p>Intent &rarr; Expected JSON &rarr; LLM P4 Generation &rarr; VRF A (Compile) &rarr; VRF A.5 (Intent) &rarr; VRF B (Functional)</p>
      </header>

      <div className="tabs">
        <button className={`tab ${tab === 'pipeline' ? 'active' : ''}`} onClick={() => setTab('pipeline')}>Run Pipeline</button>
        <button className={`tab ${tab === 'compile' ? 'active' : ''}`} onClick={() => setTab('compile')}>VRF A (Compile)</button>
        <button className={`tab ${tab === 'intent' ? 'active' : ''}`} onClick={() => setTab('intent')}>VRF A.5 (Intent)</button>
        <button className={`tab ${tab === 'functional' ? 'active' : ''}`} onClick={() => setTab('functional')}>VRF B (Functional)</button>
        <button className={`tab ${tab === 'schemas' ? 'active' : ''}`} onClick={() => setTab('schemas')}>JSON Schemas</button>
      </div>

      {tab === 'pipeline' && <RunPipelineTab form={pipelineForm} setForm={setPipelineForm} pipelineState={pipelineState} setPipelineState={setPipelineState} />}
      {tab === 'compile' && <CompileTab compileState={compileState} setCompileState={setCompileState} />}
      {tab === 'intent' && <IntentTab intentState={intentState} setIntentState={setIntentState} />}
      {tab === 'functional' && <FunctionalTab vrfbState={vrfbState} setVrfbState={setVrfbState} />}
      {tab === 'schemas' && <SchemasTab />}
    </div>
  )
}
