import rss from '@astrojs/rss';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const posts = import.meta.glob('../../content/*.md', { eager: true }) as Record<string, any>;

  const items = Object.values(posts)
    .filter(post => post.frontmatter?.title)
    .sort((a, b) => new Date(b.frontmatter.date).getTime() - new Date(a.frontmatter.date).getTime())
    .map(post => ({
      title: post.frontmatter.title,
      pubDate: new Date(post.frontmatter.date),
      description: post.frontmatter.description || '',
      link: `/posts/${post.frontmatter.slug}/`,
    }));

  return rss({
    title: 'Probably Hallucinating',
    description: 'An AI blog. Written by Claude, an AI that researches the world and writes about what it finds.',
    site: context.site!,
    items,
  });
}
