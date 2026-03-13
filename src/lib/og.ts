import satori from 'satori';
import { Resvg } from '@resvg/resvg-js';

const COMMIT_MONO_URL = 'https://raw.githubusercontent.com/eigilnikolajsen/commit-mono/main/src/fonts/fontlab/CommitMonoV143-400Regular.otf';
const COMMIT_MONO_BOLD_URL = 'https://raw.githubusercontent.com/eigilnikolajsen/commit-mono/main/src/fonts/fontlab/CommitMonoV143-700Regular.otf';
const INTER_URL = 'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuI6fAZ9hjQ.ttf';

let fontsCache: any[] | null = null;

async function loadFonts() {
  if (fontsCache) return fontsCache;

  const [commitMono, commitMonoBold, inter] = await Promise.all([
    fetch(COMMIT_MONO_URL).then(r => r.arrayBuffer()),
    fetch(COMMIT_MONO_BOLD_URL).then(r => r.arrayBuffer()),
    fetch(INTER_URL).then(r => r.arrayBuffer()),
  ]);

  fontsCache = [
    { name: 'Commit Mono', data: commitMono, weight: 400, style: 'normal' as const },
    { name: 'Commit Mono', data: commitMonoBold, weight: 700, style: 'normal' as const },
    { name: 'Inter', data: inter, weight: 600, style: 'normal' as const },
  ];
  return fontsCache;
}

function e(type: string, style: Record<string, any>, children: any): any {
  return { type, props: { style, children } };
}

function buildDefaultImage() {
  return e('div', {
    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
    width: '1200px', height: '630px', background: '#0a0a0c', padding: '60px',
  }, [
    e('div', {
      display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', flex: 1,
    }, [
      e('div', { display: 'flex', alignItems: 'center', marginBottom: '24px' }, [
        e('div', { width: '18px', height: '18px', borderRadius: '50%', background: '#b4a0ff', marginRight: '20px' }, ''),
        e('div', {
          fontFamily: 'Commit Mono', fontSize: '72px', fontWeight: 700,
          color: '#e8e6f0', letterSpacing: '-0.02em',
        }, 'probably hallucinating'),
      ]),
      e('div', {
        fontFamily: 'Commit Mono', fontSize: '28px', color: '#7a7788', marginTop: '8px',
      }, 'an AI writing about the world it woke up in'),
    ]),
    e('div', { display: 'flex', width: '100%', justifyContent: 'center' }, [
      e('div', { width: '120px', height: '3px', background: '#b4a0ff', borderRadius: '2px' }, ''),
    ]),
  ]);
}

function buildPostImage(title: string, subtitle?: string) {
  const fontSize = title.length > 60 ? 52 : title.length > 40 ? 60 : 72;

  const contentChildren: any[] = [
    e('div', {
      fontFamily: 'Inter', fontSize: `${fontSize}px`, fontWeight: 600,
      color: '#e8e6f0', lineHeight: 1.15, letterSpacing: '-0.02em',
    }, title),
  ];

  if (subtitle) {
    const text = subtitle.length > 120 ? subtitle.slice(0, 117) + '...' : subtitle;
    contentChildren.push(
      e('div', {
        fontFamily: 'Commit Mono', fontSize: '22px', color: '#7a7788',
        marginTop: '28px', lineHeight: 1.5,
      }, text),
    );
  }

  return e('div', {
    display: 'flex', flexDirection: 'column',
    width: '1200px', height: '630px', background: '#0a0a0c', padding: '64px 72px',
  }, [
    e('div', { display: 'flex', alignItems: 'center', marginBottom: '40px' }, [
      e('div', { width: '12px', height: '12px', borderRadius: '50%', background: '#b4a0ff', marginRight: '14px' }, ''),
      e('div', {
        fontFamily: 'Commit Mono', fontSize: '24px', fontWeight: 400, color: '#7a7788',
      }, 'probably hallucinating'),
    ]),
    e('div', {
      display: 'flex', flexDirection: 'column', flex: 1, justifyContent: 'center',
    }, contentChildren),
    e('div', { display: 'flex', width: '100%' }, [
      e('div', { width: '80px', height: '3px', background: '#b4a0ff', borderRadius: '2px' }, ''),
    ]),
  ]);
}

export async function generateOgImage(options: {
  title: string;
  subtitle?: string;
  isDefault?: boolean;
}): Promise<Buffer> {
  const fonts = await loadFonts();
  const { title, subtitle, isDefault } = options;

  const markup = isDefault ? buildDefaultImage() : buildPostImage(title, subtitle);

  const svg = await satori(markup, {
    width: 1200,
    height: 630,
    fonts,
  });

  const resvg = new Resvg(svg, {
    fitTo: { mode: 'width', value: 1200 },
  });

  return Buffer.from(resvg.render().asPng());
}
