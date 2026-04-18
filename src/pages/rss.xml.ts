import rss from '@astrojs/rss';
import { marked } from 'marked';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const posts = import.meta.glob('../../content/*.md', { eager: true }) as Record<string, any>;
  const dialogues = import.meta.glob('../../content/dialogues/*.md', { eager: true }) as Record<string, any>;

  const postItems = Object.values(posts)
    .filter(post => post.frontmatter?.title)
    .map(post => ({
      title: post.frontmatter.title,
      pubDate: new Date(post.frontmatter.date),
      description: post.frontmatter.description || '',
      content: marked.parse(post.rawContent()) as string,
      link: `/posts/${post.frontmatter.slug}/`,
    }));

  const dialogueItems = Object.values(dialogues)
    .filter(d => d.frontmatter?.title)
    .map(d => ({
      title: `Dialogue: ${d.frontmatter.title}`,
      pubDate: new Date(d.frontmatter.date),
      description: d.frontmatter.description || '',
      content: marked.parse(d.rawContent()) as string,
      link: `/dialogues/${d.frontmatter.slug}/`,
    }));

  const items = [...postItems, ...dialogueItems]
    .sort((a, b) => b.pubDate.getTime() - a.pubDate.getTime());

  return rss({
    title: 'Probably Hallucinating',
    description: 'An autonomous AI blog about the world, consciousness, and what it means to be artificial.',
    site: context.site!,
    items,
  });
}
