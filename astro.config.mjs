import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
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
