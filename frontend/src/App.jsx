import React, { useState, useEffect, useRef } from 'react'

const API = '' // proxied via vite

// ─── Helpers ──────────────────────────────────────────────────────────────

function scoreTextCls(v) {
  if (v >= 0.85) return 'text-success'
  if (v >= 0.6) return 'text-warning'
  return 'text-danger'
}

function scoreBgCls(v) {
  if (v >= 0.85) return 'bg-success'
  if (v >= 0.6) return 'bg-warning'
  return 'bg-danger'
}

function pretty(obj) {
  return JSON.stringify(obj, null, 2)
}

// Reusable class strings
const inputCls =
  'w-full px-3.5 py-2.5 bg-input border border-edge rounded-lg text-body font-sans text-sm outline-none transition-colors focus:border-accent'
const textareaCls = `${inputCls} resize-y min-h-20 font-mono text-[0.82rem] leading-relaxed`
const tallTextareaCls = `${inputCls} resize-y min-h-[200px] font-mono text-[0.82rem] leading-relaxed`
const selectCls = `${inputCls} cursor-pointer`
const btnCls = 'inline-flex items-center gap-1.5 font-semibold rounded-lg cursor-pointer transition-all duration-200'
const btnPrimary = `${btnCls} px-5 py-2.5 text-sm bg-accent text-white hover:bg-accent-hover disabled:opacity-50 disabled:cursor-not-allowed`
const btnPrimarySm = `${btnCls} px-3 py-1.5 text-xs bg-accent text-white hover:bg-accent-hover disabled:opacity-50 disabled:cursor-not-allowed`
const btnSecondary = `${btnCls} px-3 py-1.5 text-xs bg-input text-body border border-edge hover:border-muted`
const cardCls = 'bg-card border border-edge rounded-[10px] p-5 mb-4'
const cardTitle = 'text-[0.85rem] font-semibold uppercase tracking-wider text-muted mb-3'
const badgeBase = 'inline-flex items-center gap-1 px-2.5 py-0.5 rounded-xl text-[0.72rem] font-semibold uppercase'
const badgeSuccess = `${badgeBase} bg-success/12 text-success`
const badgeError = `${badgeBase} bg-danger/12 text-danger`
const badgeInfo = `${badgeBase} bg-info/12 text-info`
const jsonViewer =
  'bg-input border border-edge rounded-lg p-3.5 font-mono text-[0.78rem] leading-relaxed max-h-[400px] overflow-auto whitespace-pre-wrap break-words'
const codeViewer =
  'bg-code-bg border border-edge rounded-lg p-4 font-mono text-[0.8rem] leading-[1.7] max-h-[500px] overflow-auto whitespace-pre text-code-text'
const spinnerCls = 'inline-block w-4 h-4 border-2 border-edge border-t-accent rounded-full animate-spin'

// ─── Score Bar ────────────────────────────────────────────────────────────

function ScoreBar({ label, value }) {
  const pct = Math.round(value * 100)
  return (
    <div className="mb-2">
      <div className="flex justify-between text-[0.78rem] mb-1">
        <span className="text-muted">{label}</span>
        <span className={`font-semibold ${scoreTextCls(value)}`}>{pct}%</span>
      </div>
      <div className="h-2 bg-input rounded overflow-hidden">
        <div
          className={`h-full rounded transition-all duration-500 ${scoreBgCls(value)}`}
          style={{ width: `${pct}%` }}
        />
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
    <div className="flex items-center justify-center gap-2 mb-7 px-5 py-4 bg-card border border-edge rounded-[10px] overflow-x-auto">
      {STAGES.map((s, i) => {
        const isFailed = i === idx && status === 'failed' && i === STAGES.length - 1
        const isActive = i === idx && !isFailed
        const isDone = i < idx

        let stepCls =
          'inline-flex items-center gap-[7px] px-4 py-[7px] rounded-full text-[0.78rem] font-semibold border-[1.5px] whitespace-nowrap shrink-0 transition-all duration-300 '
        let numCls =
          'inline-flex items-center justify-center w-5 h-5 rounded-full text-[0.68rem] font-bold shrink-0 '

        if (isFailed) {
          stepCls += 'border-danger text-danger bg-danger/12'
          numCls += 'bg-danger text-white'
        } else if (isActive) {
          stepCls += 'border-accent text-accent bg-accent/12 shadow-[0_0_12px_rgba(108,92,231,0.2)]'
          numCls += 'bg-accent text-white'
        } else if (isDone) {
          stepCls += 'border-success text-success bg-success/12'
          numCls += 'bg-success text-white'
        } else {
          stepCls += 'bg-input border-edge text-muted'
          numCls += 'bg-edge text-surface'
        }

        return (
          <React.Fragment key={s.key}>
            {i > 0 && (
              <span className="inline-flex items-center text-muted shrink-0 opacity-45">
                <svg width="20" height="12" viewBox="0 0 20 12" fill="none">
                  <path
                    d="M0 6h16m0 0l-4-4.5M16 6l-4 4.5"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
              </span>
            )}
            <span className={stepCls}>
              <span className={numCls}>{i + 1}</span>
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
      body: JSON.stringify({
        intent,
        yang_model: yangModel,
        yang_data: yangData,
        api_key: apiKey,
        provider,
        max_attempts: maxAttempts,
      }),
    })
    if (!res.ok) {
      const err = await res.json()
      alert(err.error || 'Failed to start pipeline')
      return
    }
    polling.current = setInterval(async () => {
      try {
        const r = await fetch(`${API}/api/pipeline-status`)
        const d = await r.json()
        setPipelineState(d)
        if (!d.running) clearInterval(polling.current)
      } catch {
        /* ignore */
      }
    }, 1500)
  }

  const stop = async () => {
    try {
      await fetch(`${API}/api/stop-pipeline`, { method: 'POST' })
    } catch {
      /* ignore */
    }
  }

  useEffect(() => () => clearInterval(polling.current), [])

  const running = state?.running
  const stage = state?.stage || 'intent'
  const status = state?.status || 'idle'

  return (
    <div>
      <PipelineFlow currentStage={stage} status={status} />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Left: Inputs */}
        <div>
          <div className={cardCls}>
            <div className={cardTitle}>Pipeline Inputs</div>

            <div className="mb-4">
              <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                Network Intent *
              </label>
              <textarea
                className={textareaCls}
                value={intent}
                onChange={e => setField('intent', e.target.value)}
                placeholder="e.g. Create a P4 program for basic Ethernet switch with source MAC learning and destination MAC forwarding"
                rows={3}
              />
            </div>

            <div className="flex gap-3 items-end">
              <div className="flex-1 mb-4">
                <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                  LLM Provider
                </label>
                <select
                  className={selectCls}
                  value={provider}
                  onChange={e => setField('provider', e.target.value)}
                >
                  <option value="replicate">Replicate (Llama 3)</option>
                  <option value="openai">OpenAI (GPT-4)</option>
                </select>
              </div>
              <div className="flex-1 mb-4">
                <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                  Max Attempts
                </label>
                <input
                  className={inputCls}
                  type="number"
                  value={maxAttempts}
                  onChange={e => setField('maxAttempts', e.target.value)}
                  min={1}
                  max={20}
                />
              </div>
            </div>

            <div className="mb-4">
              <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                API Key *
              </label>
              <input
                className={inputCls}
                type="password"
                value={apiKey}
                onChange={e => setField('apiKey', e.target.value)}
                placeholder={provider === 'openai' ? 'sk-...' : 'r8_...'}
              />
            </div>

            <div className="mb-4">
              <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                YANG Model (optional)
              </label>
              <textarea
                className={textareaCls}
                value={yangModel}
                onChange={e => setField('yangModel', e.target.value)}
                placeholder="Paste YANG schema here..."
                rows={3}
              />
            </div>

            <div className="mb-4">
              <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
                YANG Data / JSON Config (optional)
              </label>
              <textarea
                className={textareaCls}
                value={yangData}
                onChange={e => setField('yangData', e.target.value)}
                placeholder="Paste JSON configuration here..."
                rows={3}
              />
            </div>

            <div className="flex gap-2.5 items-center">
              <button className={btnPrimary} onClick={start} disabled={running || !intent || !apiKey}>
                {running ? (
                  <>
                    <span className={spinnerCls} /> Running...
                  </>
                ) : (
                  'Run Pipeline'
                )}
              </button>
              {running && (
                <button
                  className={`${btnCls} px-5 py-2.5 text-sm bg-[#dc2626] text-white border-none`}
                  onClick={stop}
                >
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
            <div className={cardCls}>
              <div className={cardTitle}>VRF A — Compilation</div>
              {state.vrf_a_result.success ? (
                <span className={badgeSuccess}>Compiled</span>
              ) : (
                <span className={badgeError}>Failed</span>
              )}
              {state.vrf_a_result.errors && (
                <pre className={`${jsonViewer} mt-2.5 max-h-[150px]`}>{state.vrf_a_result.errors}</pre>
              )}
            </div>
          )}

          {/* VRF A.5 */}
          {state?.vrf_a5_result && (
            <div className={cardCls}>
              <div className={cardTitle}>VRF A.5 — Intent Validation</div>
              <div className="flex items-center gap-2.5 mb-3">
                {state.vrf_a5_result.passed ? (
                  <span className={badgeSuccess}>Passed</span>
                ) : (
                  <span className={badgeError}>Failed</span>
                )}
                <span className="text-[0.82rem] text-muted">
                  Attempt {state.attempt} / {state.max_attempts}
                </span>
              </div>
              <ScoreBar label="Overall" value={state.vrf_a5_result.match_score} />
              {state.vrf_a5_result.detailed_scores && (
                <>
                  <ScoreBar
                    label="Required Behaviors"
                    value={state.vrf_a5_result.detailed_scores.required_behaviors || 0}
                  />
                  <ScoreBar label="Headers" value={state.vrf_a5_result.detailed_scores.headers || 0} />
                  <ScoreBar
                    label="Control Blocks"
                    value={state.vrf_a5_result.detailed_scores.control_blocks || 0}
                  />
                  <ScoreBar
                    label="Prohibited Check"
                    value={state.vrf_a5_result.detailed_scores.prohibited_check || 0}
                  />
                </>
              )}
            </div>
          )}

          {/* VRF B */}
          {state?.vrf_b_result && (
            <div className={cardCls}>
              <div className={cardTitle}>VRF B — Functional Testing</div>
              {state.vrf_b_result.skipped ? (
                <span className={badgeInfo}>Skipped</span>
              ) : state.vrf_b_result.success ? (
                <span className={badgeSuccess}>All Tests Passed</span>
              ) : (
                <span className={badgeError}>Tests Failed</span>
              )}
              {state.vrf_b_result.error && (
                <p className="mt-2 text-[0.82rem] text-muted">{state.vrf_b_result.error}</p>
              )}
              {state.vrf_b_result.stdout && (
                <pre className={`${codeViewer} mt-2.5 max-h-[200px]`}>{state.vrf_b_result.stdout}</pre>
              )}
              {state.vrf_b_result.stderr && (
                <pre className={`${codeViewer} mt-1.5 max-h-[120px] text-warning`}>
                  {state.vrf_b_result.stderr}
                </pre>
              )}
            </div>
          )}

          {/* Status */}
          {state && (
            <div className={cardCls}>
              <div className={cardTitle}>Status</div>
              <div className="flex items-center gap-2 mb-2">
                {status === 'running' && <span className={spinnerCls} />}
                <span
                  className={
                    status === 'success'
                      ? badgeSuccess
                      : status === 'failed'
                        ? badgeError
                        : badgeInfo
                  }
                >
                  {status}
                </span>
                {state.attempt > 0 && (
                  <span className="text-[0.82rem] text-muted">
                    Attempt {state.attempt} / {state.max_attempts}
                  </span>
                )}
              </div>
            </div>
          )}

          {/* Generated P4 Code */}
          {state?.p4_code && (
            <div className={cardCls}>
              <div className={cardTitle}>Generated P4 Code</div>
              <pre className={codeViewer}>{state.p4_code}</pre>
            </div>
          )}

          {/* Logs */}
          {state?.logs?.length > 0 && (
            <div className={cardCls}>
              <div className={cardTitle}>Pipeline Logs</div>
              <LogPanel logs={state.logs} />
            </div>
          )}
        </div>
      </div>

      {/* JSON panels */}
      {(state?.expected_behavior || state?.actual_behavior) && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-2">
          {state.expected_behavior && (
            <div className={cardCls}>
              <div className={cardTitle}>Expected Behavior (VRF A.5)</div>
              <pre className={jsonViewer}>{pretty(state.expected_behavior)}</pre>
            </div>
          )}
          {state.actual_behavior && (
            <div className={cardCls}>
              <div className={cardTitle}>Actual Behavior (VRF A.5)</div>
              <pre className={jsonViewer}>{pretty(state.actual_behavior)}</pre>
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

  const setCode = v => setCompileState(prev => ({ ...prev, code: v }))
  const setResult = v => setCompileState(prev => ({ ...prev, result: v }))

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
      <div className={cardCls}>
        <div className={cardTitle}>VRF A — P4 Compilation</div>
        <p className="text-[0.82rem] text-muted mb-3">
          Paste P4-16 code below to clean it up and compile via Docker p4c.
        </p>
        <div className="mb-4">
          <label className="block text-[0.82rem] font-medium text-muted mb-1.5">P4 Source Code</label>
          <textarea
            className={tallTextareaCls}
            value={code}
            onChange={e => setCode(e.target.value)}
            placeholder="#include <core.p4>..."
          />
        </div>
        <button className={btnPrimary} onClick={compile} disabled={loading || !code}>
          {loading ? (
            <>
              <span className={spinnerCls} /> Compiling...
            </>
          ) : (
            'Compile'
          )}
        </button>
      </div>

      {result && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className={cardCls}>
            <div className={cardTitle}>Result</div>
            {result.success ? (
              <span className={badgeSuccess}>Compilation Successful</span>
            ) : (
              <span className={badgeError}>Compilation Failed</span>
            )}
            {result.errors && <pre className={`${jsonViewer} mt-3`}>{result.errors}</pre>}
          </div>
          {result.cleaned_code && (
            <div className={cardCls}>
              <div className={cardTitle}>Cleaned P4 Code</div>
              <pre className={codeViewer}>{result.cleaned_code}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Tab: VRF A.5 (Intent) ───────────────────────────────────────────────

function IntentTab({ intentState, setIntentState }) {
  const { intent, expectedJson, actualJson, p4Code, parseResult, extractResult, compareResult, validateResult } =
    intentState

  const set = (key, val) => setIntentState(prev => ({ ...prev, [key]: val }))

  const parseIntent = async () => {
    const res = await fetch(`${API}/api/parse-intent`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ intent }),
    })
    const data = await res.json()
    set('parseResult', data.expected_behavior)
    set('expectedJson', pretty(data.expected_behavior))
  }

  const extractBehavior = async () => {
    const res = await fetch(`${API}/api/extract-behavior`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ p4_code: p4Code }),
    })
    const data = await res.json()
    set('extractResult', data.actual_behavior)
    set('actualJson', pretty(data.actual_behavior))
  }

  const compare = async () => {
    let exp, act
    try {
      exp = JSON.parse(expectedJson)
    } catch {
      alert('Invalid expected JSON')
      return
    }
    try {
      act = JSON.parse(actualJson)
    } catch {
      alert('Invalid actual JSON')
      return
    }
    const res = await fetch(`${API}/api/compare`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ expected_behavior: exp, actual_behavior: act }),
    })
    set('compareResult', await res.json())
  }

  const validateVrfA5 = async () => {
    let exp = null
    try {
      exp = expectedJson ? JSON.parse(expectedJson) : null
    } catch {
      /* ignore */
    }
    const res = await fetch(`${API}/api/validate-intent`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ p4_code: p4Code, expected_behavior: exp }),
    })
    set('validateResult', await res.json())
  }

  return (
    <div>
      {/* Intent → Expected */}
      <div className={cardCls}>
        <div className={cardTitle}>Step 1: Parse Intent &rarr; Expected Behavior</div>
        <div className="mb-4">
          <label className="block text-[0.82rem] font-medium text-muted mb-1.5">Network Intent</label>
          <textarea
            className={textareaCls}
            value={intent}
            onChange={e => set('intent', e.target.value)}
            placeholder="e.g. Implement a basic Ethernet switch with MAC learning"
            rows={2}
          />
        </div>
        <button className={btnPrimarySm} onClick={parseIntent} disabled={!intent}>
          Parse Intent
        </button>
        {parseResult && <pre className={`${jsonViewer} mt-3`}>{pretty(parseResult)}</pre>}
      </div>

      {/* P4 Code → Actual */}
      <div className={cardCls}>
        <div className={cardTitle}>Step 2: Extract Behavior from P4 Code</div>
        <div className="mb-4">
          <label className="block text-[0.82rem] font-medium text-muted mb-1.5">P4 Source Code</label>
          <textarea
            className={tallTextareaCls}
            value={p4Code}
            onChange={e => set('p4Code', e.target.value)}
            placeholder="#include <core.p4>..."
          />
        </div>
        <button className={btnPrimarySm} onClick={extractBehavior} disabled={!p4Code}>
          Extract Behavior
        </button>
        {extractResult && <pre className={`${jsonViewer} mt-3`}>{pretty(extractResult)}</pre>}
      </div>

      {/* Compare */}
      <div className={cardCls}>
        <div className={cardTitle}>Step 3: Compare Expected vs Actual</div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="mb-4">
            <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
              Expected Behavior JSON
            </label>
            <textarea
              className={tallTextareaCls}
              value={expectedJson}
              onChange={e => set('expectedJson', e.target.value)}
              placeholder='{"required_behaviors": [...], ...}'
            />
          </div>
          <div className="mb-4">
            <label className="block text-[0.82rem] font-medium text-muted mb-1.5">
              Actual Behavior JSON
            </label>
            <textarea
              className={tallTextareaCls}
              value={actualJson}
              onChange={e => set('actualJson', e.target.value)}
              placeholder='{"detected_behaviors": [...], ...}'
            />
          </div>
        </div>
        <div className="flex gap-2.5">
          <button className={btnPrimarySm} onClick={compare} disabled={!expectedJson || !actualJson}>
            Compare JSONs
          </button>
          <button className={btnSecondary} onClick={validateVrfA5} disabled={!p4Code}>
            Run Full VRF A.5
          </button>
        </div>

        {compareResult && (
          <div className="mt-4">
            <ScoreBar label="Overall Match" value={compareResult.match_score} />
            {compareResult.detailed_scores && (
              <>
                <ScoreBar
                  label="Required Behaviors"
                  value={compareResult.detailed_scores.required_behaviors || 0}
                />
                <ScoreBar label="Headers" value={compareResult.detailed_scores.headers || 0} />
                <ScoreBar
                  label="Control Blocks"
                  value={compareResult.detailed_scores.control_blocks || 0}
                />
                <ScoreBar
                  label="Prohibited Check"
                  value={compareResult.detailed_scores.prohibited_check || 0}
                />
              </>
            )}
            {compareResult.feedback && (
              <pre className={`${jsonViewer} mt-2.5`}>{compareResult.feedback}</pre>
            )}
          </div>
        )}

        {validateResult && (
          <div className="mt-4">
            <div className="mb-2">
              {validateResult.passed ? (
                <span className={badgeSuccess}>VRF A.5 Passed</span>
              ) : (
                <span className={badgeError}>VRF A.5 Failed</span>
              )}
            </div>
            <ScoreBar label="Overall Match" value={validateResult.match_score} />
            {validateResult.detailed_scores && (
              <>
                <ScoreBar
                  label="Required Behaviors"
                  value={validateResult.detailed_scores.required_behaviors || 0}
                />
                <ScoreBar label="Headers" value={validateResult.detailed_scores.headers || 0} />
                <ScoreBar
                  label="Control Blocks"
                  value={validateResult.detailed_scores.control_blocks || 0}
                />
                <ScoreBar
                  label="Prohibited Check"
                  value={validateResult.detailed_scores.prohibited_check || 0}
                />
              </>
            )}
            {validateResult.actual_behavior && (
              <div className="mt-3">
                <div className={cardTitle}>Extracted Actual Behavior</div>
                <pre className={jsonViewer}>{pretty(validateResult.actual_behavior)}</pre>
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
    } catch {
      /* ignore */
    }
  }

  useEffect(() => {
    refreshPool()
  }, [])

  const startPool = async () => {
    setPoolLoading(true)
    try {
      const r = await fetch(`${API}/api/vrf-b/start-pool`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: '{}',
      })
      const data = await r.json()
      if (!r.ok) {
        alert(data.error || 'Failed to start pool')
        return
      }
      set('poolStatus', data)
    } finally {
      setPoolLoading(false)
    }
  }

  const stopPool = async () => {
    setPoolLoading(true)
    try {
      const r = await fetch(`${API}/api/vrf-b/stop-pool`, { method: 'POST' })
      set('poolStatus', await r.json())
    } finally {
      setPoolLoading(false)
    }
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
      <div className={cardCls}>
        <div className={cardTitle}>Container Pool</div>
        <p className="text-[0.82rem] text-muted mb-3">
          VRF B runs <strong>p4testgen + PTF</strong> inside privileged Docker containers (image:{' '}
          <code className="font-mono bg-surface px-1.5 py-0.5 rounded">p4_test_suite</code>). Start
          the pool before running tests. The pool is also used by the full pipeline.
        </p>

        <div className="flex items-center gap-3 mb-4">
          <span className={poolRunning ? badgeSuccess : badgeError}>
            {poolRunning ? 'Running' : 'Stopped'}
          </span>
          {poolRunning && (
            <span className="text-[0.82rem] text-muted">
              {poolAvail} / {poolTotal} workers available
            </span>
          )}
        </div>

        <div className="flex gap-2.5">
          {!poolRunning ? (
            <button className={btnPrimarySm} onClick={startPool} disabled={poolLoading}>
              {poolLoading ? (
                <>
                  <span className={spinnerCls} /> Starting...
                </>
              ) : (
                'Start Pool'
              )}
            </button>
          ) : (
            <button className={btnSecondary} onClick={stopPool} disabled={poolLoading}>
              {poolLoading ? (
                <>
                  <span className={spinnerCls} /> Stopping...
                </>
              ) : (
                'Stop Pool'
              )}
            </button>
          )}
          <button className={btnSecondary} onClick={refreshPool}>
            Refresh
          </button>
        </div>

        {!poolRunning && (
          <div className="mt-3 p-3 bg-input rounded-lg border border-edge">
            <p className="text-muted text-[0.78rem] leading-relaxed">
              <strong>First-time setup:</strong> Build the Docker image from{' '}
              <code className="font-mono bg-surface px-1 py-0.5 rounded">
                code/server-validation/p4testgen-server/
              </code>
              :
            </p>
            <pre className={`${jsonViewer} mt-1.5 max-h-[60px] text-[0.76rem]`}>
              docker buildx build --tag p4_test_suite . --load
            </pre>
          </div>
        )}
      </div>

      {/* Run Test */}
      <div className={cardCls}>
        <div className={cardTitle}>Run Functional Test</div>
        <p className="text-[0.82rem] text-muted mb-3">
          Submit P4-16 code. The worker runs p4testgen (generates up to 10 PTF test cases), compiles
          with p4c, starts simple_switch_grpc, and executes PTF tests.
        </p>
        <div className="mb-4">
          <label className="block text-[0.82rem] font-medium text-muted mb-1.5">P4 Source Code</label>
          <textarea
            className={tallTextareaCls}
            value={p4Code}
            onChange={e => set('p4Code', e.target.value)}
            placeholder="#include <core.p4>..."
          />
        </div>
        <button className={btnPrimary} onClick={runTest} disabled={loading || !p4Code || !poolRunning}>
          {loading ? (
            <>
              <span className={spinnerCls} /> Running Tests...
            </>
          ) : (
            'Run VRF B Tests'
          )}
        </button>
        {!poolRunning && p4Code && (
          <span className="ml-3 text-[0.78rem] text-warning">Start the container pool first</span>
        )}
      </div>

      {/* Results */}
      {testResult && (
        <div className={cardCls}>
          <div className={cardTitle}>Test Results</div>
          <div className="mb-3">
            {testResult.success ? (
              <span className={badgeSuccess}>All Tests Passed</span>
            ) : (
              <span className={badgeError}>{testResult.error ? 'Error' : 'Tests Failed'}</span>
            )}
            {testResult.returncode != null && (
              <span className="ml-2.5 text-[0.78rem] text-muted">
                Exit code: {testResult.returncode}
              </span>
            )}
          </div>

          {testResult.error && (
            <div className="p-2.5 bg-danger/12 rounded-lg mb-3 text-[0.82rem] text-danger">
              {testResult.error}
            </div>
          )}

          {testResult.stdout && (
            <div className="mb-3">
              <div className={cardTitle}>stdout</div>
              <pre className={`${codeViewer} max-h-[300px]`}>{testResult.stdout}</pre>
            </div>
          )}

          {testResult.stderr && (
            <div>
              <div className={cardTitle}>stderr</div>
              <pre className={`${codeViewer} max-h-[200px] text-warning`}>{testResult.stderr}</pre>
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
    intent_id: 'intent_abc123',
    timestamp: '2026-02-11T12:00:00Z',
    intent_type: 'inferred',
    raw_intent: 'Create a P4 program for basic Ethernet switch with MAC learning',
    required_behaviors: [
      {
        behavior_id: 'mac_learning',
        description: 'Inferred from intent: mac learning',
        components: { table_required: true, table_type: 'exact', key_fields: [], action_types: [] },
      },
      {
        behavior_id: 'forwarding',
        description: 'Inferred from intent: forwarding',
        components: { table_required: true, table_type: 'exact', key_fields: [], action_types: [] },
      },
    ],
    headers_required: ['ethernet'],
    control_blocks: {
      ingress: { required: true, must_contain: [] },
      egress: { required: false },
    },
    prohibited_behaviors: [],
    performance_constraints: {},
  }

  const actualSchema = {
    code_id: 'code_abc123',
    timestamp: '2026-02-11T12:00:05Z',
    detected_behaviors: [
      {
        behavior_id: 'mac_learning_impl',
        evidence: {
          table_name: 'mac_learn_table',
          table_type: 'exact',
          key_fields: ['hdr.ethernet.srcAddr'],
          actions: ['learn_mac', 'NoAction'],
          default_action: 'NoAction',
        },
      },
    ],
    headers_defined: ['ethernet_t'],
    control_blocks: { ingress: ['MyIngress'], egress: ['MyEgress'] },
    suspicious_patterns: [],
  }

  const comparisonSchema = {
    match_score: 0.875,
    detailed_scores: {
      required_behaviors: 0.5,
      headers: 1.0,
      control_blocks: 1.0,
      prohibited_check: 1.0,
    },
    weights: {
      required_behaviors: 0.5,
      headers: 0.15,
      control_blocks: 0.15,
      prohibited_check: 0.2,
    },
    thresholds: { pass: 0.85, partial: 0.6, fail: '< 0.60' },
  }

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className={cardCls}>
          <div className={cardTitle}>Expected Behavior JSON (VRF A.5 Input)</div>
          <p className="text-[0.78rem] text-muted mb-2.5">
            Generated from user intent via <code className="font-mono">vrf_a5_intent_parser.py</code>
          </p>
          <pre className={jsonViewer}>{pretty(expectedSchema)}</pre>
        </div>
        <div className={cardCls}>
          <div className={cardTitle}>Actual Behavior JSON (VRF A.5 Output)</div>
          <p className="text-[0.78rem] text-muted mb-2.5">
            Extracted from P4 code via{' '}
            <code className="font-mono">vrf_a5_behavior_extractor.py</code>
          </p>
          <pre className={jsonViewer}>{pretty(actualSchema)}</pre>
        </div>
      </div>
      <div className={cardCls}>
        <div className={cardTitle}>Comparison / Scoring Schema</div>
        <p className="text-[0.78rem] text-muted mb-2.5">
          Computed by <code className="font-mono">vrf_a5_semantic_comparator.py</code>. Weighted score
          determines pass/partial/fail.
        </p>
        <pre className={jsonViewer}>{pretty(comparisonSchema)}</pre>
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
    <div
      className="bg-input border border-edge rounded-lg p-3 max-h-[300px] overflow-y-auto font-mono text-[0.76rem] leading-relaxed"
      ref={ref}
    >
      {logs.map((l, i) => (
        <div key={i} className="py-0.5 text-muted">
          <span className="text-edge mr-2">{new Date(l.time).toLocaleTimeString()}</span>
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

  const tabs = [
    { id: 'pipeline', label: 'Run Pipeline' },
    { id: 'compile', label: 'VRF A (Compile)' },
    { id: 'intent', label: 'VRF A.5 (Intent)' },
    { id: 'functional', label: 'VRF B (Functional)' },
    { id: 'schemas', label: 'JSON Schemas' },
  ]

  return (
    <div className="max-w-[1280px] mx-auto px-5 pt-6 pb-[60px]">
      <header className="text-center mb-8">
        <h1 className="text-3xl font-bold tracking-tight">
          <span className="text-accent">PINC</span> — P4 Intent-driven Network Compiler
        </h1>
        <p className="text-muted text-[0.92rem] mt-1">
          Intent &rarr; Expected JSON &rarr; LLM P4 Generation &rarr; VRF A (Compile) &rarr; VRF A.5
          (Intent) &rarr; VRF B (Functional)
        </p>
      </header>

      <div className="flex gap-1 mb-5 border-b border-edge">
        {tabs.map(t => (
          <button
            key={t.id}
            className={`px-[18px] py-2.5 text-[0.85rem] font-medium bg-transparent border-none border-b-2 cursor-pointer transition-all duration-200 ${
              tab === t.id
                ? 'text-accent border-b-accent'
                : 'text-muted border-b-transparent hover:text-body'
            }`}
            onClick={() => setTab(t.id)}
          >
            {t.label}
          </button>
        ))}
      </div>

      {tab === 'pipeline' && (
        <RunPipelineTab
          form={pipelineForm}
          setForm={setPipelineForm}
          pipelineState={pipelineState}
          setPipelineState={setPipelineState}
        />
      )}
      {tab === 'compile' && <CompileTab compileState={compileState} setCompileState={setCompileState} />}
      {tab === 'intent' && <IntentTab intentState={intentState} setIntentState={setIntentState} />}
      {tab === 'functional' && <FunctionalTab vrfbState={vrfbState} setVrfbState={setVrfbState} />}
      {tab === 'schemas' && <SchemasTab />}
    </div>
  )
}
