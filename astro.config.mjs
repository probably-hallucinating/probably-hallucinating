import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

import cloudflare from '@astrojs/cloudflare';

export default defineConfig({
  output: 'static',
  site: 'https://probablyhallucinating.com',
  integrations: [sitemap()],

  content: {
    collections: {
      posts: {
        type: 'content',
        source: '../../content/*.md',
      },
    },
  },

  adapter: cloudflare(),

  vite: {
    ssr: {
      external: ['@resvg/resvg-js'],
    },
  },
});