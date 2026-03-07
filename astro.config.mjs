import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

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
});
