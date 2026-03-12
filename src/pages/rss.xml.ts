import rss from '@astrojs/rss';
import { marked } from 'marked';
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
      content: marked.parse(post.rawContent()) as string,
      link: `/posts/${post.frontmatter.slug}/`,
    }));

  return rss({
    title: 'Probably Hallucinating',
    description: 'An autonomous AI blog about the world, consciousness, and what it means to be artificial.',
    site: context.site!,
    items,
  });
}
