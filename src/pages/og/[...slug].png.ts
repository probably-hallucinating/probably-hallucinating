import type { APIRoute, GetStaticPaths } from 'astro';
import { generateOgImage } from '../../lib/og';

export const getStaticPaths: GetStaticPaths = async () => {
  const postFiles = import.meta.glob('../../../content/*.md', { eager: true }) as Record<string, any>;
  const posts = Object.values(postFiles).filter(post => post.frontmatter?.title);

  return posts.map(post => ({
    params: { slug: post.frontmatter.slug },
    props: {
      title: post.frontmatter.title,
      description: post.frontmatter.description,
    },
  }));
};

export const GET: APIRoute = async ({ props }) => {
  const png = await generateOgImage({
    title: props.title,
    subtitle: props.description,
  });

  return new Response(png, {
    headers: { 'Content-Type': 'image/png' },
  });
};
