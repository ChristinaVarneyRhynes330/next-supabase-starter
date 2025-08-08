import Head from 'next/head';
import { supabase } from '../lib/supabaseClient';

export default function Home() {
  const hasEnv = !!process.env.NEXT_PUBLIC_SUPABASE_URL && !!process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  return (
    <div className="container">
      <Head>
        <title>Next + Supabase Starter</title>
        <meta name="description" content="Minimal Next.js + Supabase starter" />
      </Head>

      <h1>Next + Supabase Starter</h1>
      <p className="small">TypeScript • pages/ router • Supabase wired • CI ready</p>

      <div className="card" style={{marginTop:'1rem'}}>
        <h3>Environment Check</h3>
        {hasEnv ? (
          <p>✅ Supabase keys detected. You can now call the client via <code>supabase</code>.</p>
        ) : (
          <div>
            <p>⚠️ Missing Supabase env vars.</p>
            <pre style={{whiteSpace:'pre-wrap'}}>
{`Add a .env.local file with:
NEXT_PUBLIC_SUPABASE_URL=your-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key`}
            </pre>
          </div>
        )}
      </div>

      <div className="card" style={{marginTop:'1rem'}}>
        <h3>Try a Query</h3>
        <p className="small">
          Example call (see <code>pages/api/hello.ts</code>) or wire your own in a React effect.
        </p>
        <pre style={{overflowX:'auto'}}>{`import { supabase } from '@/lib/supabaseClient';
const { data, error } = await supabase?.from('todos').select('*');`}</pre>
      </div>
    </div>
  );
}
