import Link from 'next/link';

export default function Header() {
  return (
    <header style={{padding:'1rem 0'}}>
      <nav style={{display:'flex', gap:'1rem'}}>
        <Link href="/">Home</Link>
        <Link href="/api/hello">API</Link>
        <a href="https://supabase.com/docs" target="_blank" rel="noreferrer">Supabase Docs</a>
        <a href="https://nextjs.org/docs" target="_blank" rel="noreferrer">Next.js Docs</a>
      </nav>
    </header>
  );
}
