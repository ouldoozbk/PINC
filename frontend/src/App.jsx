import React, { useEffect, useState } from 'react'

const API = import.meta.env.VITE_API_BASE_URL || '' // empty uses vite proxy/same-origin

const inputCls =
  'w-full px-3.5 py-2.5 bg-input border border-edge rounded-lg text-body font-sans text-sm outline-none transition-colors focus:border-accent'
const textareaCls = `${inputCls} resize-y min-h-[110px] font-mono text-[0.82rem] leading-relaxed`
const btnCls =
  'inline-flex items-center gap-1.5 px-5 py-2.5 text-sm font-semibold rounded-lg cursor-pointer transition-all duration-200 bg-accent text-white hover:bg-accent-hover disabled:opacity-50 disabled:cursor-not-allowed'
const cardCls = 'bg-card border border-edge rounded-[10px] p-5'
const cardTitle = 'text-[0.85rem] font-semibold uppercase tracking-wider text-muted mb-3'
const jsonViewer =
  'bg-input border border-edge rounded-lg p-3.5 font-mono text-[0.78rem] leading-relaxed max-h-[420px] overflow-auto whitespace-pre-wrap break-words'
const codeViewer =
  'bg-code-bg border border-edge rounded-lg p-4 font-mono text-[0.8rem] leading-[1.7] max-h-[520px] overflow-auto whitespace-pre text-code-text'

function pretty(value) {
  return JSON.stringify(value, null, 2)
}

async function callJson(path, options = {}) {
  const response = await fetch(`${API}${path}`, options)
  let data = null
  try {
    data = await response.json()
  } catch {
    data = { detail: `Non-JSON response (HTTP ${response.status})` }
  }
  if (!response.ok) {
    const message = data?.detail || data?.error || `HTTP ${response.status}`
    throw new Error(message)
  }
  return data
}

export default function App() {
  const [annotation, setAnnotation] = useState('Drop all UDP packets on port 53.')
  const [p4Code, setP4Code] = useState('')

  const [health, setHealth] = useState(null)
  const [predictResult, setPredictResult] = useState(null)
  const [generateResult, setGenerateResult] = useState(null)
  const [validateResult, setValidateResult] = useState(null)
  const [error, setError] = useState('')

  const [predicting, setPredicting] = useState(false)
  const [generating, setGenerating] = useState(false)
  const [validating, setValidating] = useState(false)

  const refreshHealth = async () => {
    try {
      setError('')
      const data = await callJson('/health')
      setHealth(data)
    } catch (e) {
      setError(e.message)
    }
  }

  useEffect(() => {
    refreshHealth()
  }, [])

  const classify = async () => {
    if (!annotation.trim()) return
    try {
      setPredicting(true)
      setError('')
      const data = await callJson('/classify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ annotation }),
      })
      setPredictResult(data)
    } catch (e) {
      setError(e.message)
    } finally {
      setPredicting(false)
    }
  }

  const generate = async () => {
    if (!annotation.trim()) return
    try {
      setGenerating(true)
      setError('')
      const data = await callJson('/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ annotation }),
      })
      setGenerateResult(data)
      setP4Code(data?.p4_code || '')
    } catch (e) {
      setError(e.message)
    } finally {
      setGenerating(false)
    }
  }

  const validate = async () => {
    if (!p4Code.trim()) return
    try {
      setValidating(true)
      setError('')
      const data = await callJson('/validate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ p4_code: p4Code }),
      })
      setValidateResult(data)
    } catch (e) {
      setError(e.message)
    } finally {
      setValidating(false)
    }
  }

  const compiled = generateResult?.verification?.compiled
  const compiledLabel =
    compiled === true ? 'compiled: true' : compiled === false ? 'compiled: false' : 'compiled: not checked'

  return (
    <div className="max-w-[1100px] mx-auto px-5 pt-6 pb-[60px]">
      <header className="text-center mb-7">
        <h1 className="text-3xl font-bold tracking-tight">
          <span className="text-accent">PINC</span> Intent Classifier + Generator
        </h1>
        <p className="text-muted text-[0.92rem] mt-1">
          Frontend wired to `app.py` endpoints: `/health`, `/classify`, `/generate`, `/validate`
        </p>
      </header>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <section className={cardCls}>
          <div className={cardTitle}>Input</div>
          <label className="block text-[0.82rem] font-medium text-muted mb-1.5">Network intent</label>
          <textarea
            className={textareaCls}
            value={annotation}
            onChange={e => setAnnotation(e.target.value)}
            placeholder="e.g. Drop all UDP packets on port 53."
          />
          <div className="flex flex-wrap gap-2.5 mt-4">
            <button className={btnCls} disabled={predicting || !annotation.trim()} onClick={classify}>
              {predicting ? 'Classifying...' : 'Classify (/classify)'}
            </button>
            <button className={btnCls} disabled={generating || !annotation.trim()} onClick={generate}>
              {generating ? 'Generating...' : 'Generate (/generate)'}
            </button>
            <button className={btnCls} disabled={validating || !p4Code.trim()} onClick={validate}>
              {validating ? 'Validating...' : 'Validate (/validate)'}
            </button>
            <button className={btnCls} onClick={refreshHealth}>
              Refresh Health
            </button>
          </div>
          {error && <p className="mt-3 text-danger text-sm">{error}</p>}
        </section>

        <section className={cardCls}>
          <div className={cardTitle}>Service Health</div>
          <pre className={jsonViewer}>{health ? pretty(health) : 'No health data yet'}</pre>
        </section>

        <section className={cardCls}>
          <div className={cardTitle}>Prediction</div>
          <pre className={jsonViewer}>{predictResult ? pretty(predictResult) : 'No /classify result yet'}</pre>
        </section>

        <section className={cardCls}>
          <div className={cardTitle}>Generation Summary</div>
          {generateResult && (
            <p className="text-[0.82rem] text-muted mb-2">
              intent: <strong>{generateResult.intent || '-'}</strong> | {compiledLabel}
            </p>
          )}
          <pre className={jsonViewer}>{generateResult ? pretty(generateResult) : 'No /generate result yet'}</pre>
        </section>
      </div>

      <section className={`${cardCls} mt-4`}>
        <div className={cardTitle}>P4 Code</div>
        <textarea
          className={`${textareaCls} min-h-[260px]`}
          value={p4Code}
          onChange={e => setP4Code(e.target.value)}
          placeholder="Generated P4 appears here. You can edit it before /validate."
        />
        <div className="mt-3">
          <pre className={codeViewer}>{p4Code || 'No P4 code yet'}</pre>
        </div>
      </section>

      <section className={`${cardCls} mt-4`}>
        <div className={cardTitle}>Validation Result</div>
        <pre className={jsonViewer}>{validateResult ? pretty(validateResult) : 'No /validate result yet'}</pre>
      </section>
    </div>
  )
}
