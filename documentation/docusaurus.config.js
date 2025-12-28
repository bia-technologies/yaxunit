// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

import rehypeShiki from "@shikijs/rehype";

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'YAx Unit',
  tagline: 'Модульные тесты для 1С - это не сложно',
  favicon: 'img/logo.svg',

  // Set the production url of your site here
  url: 'https://bia-technologies.github.io/',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/yaxunit',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'bia-technologies', // Usually your GitHub org/user name.
  projectName: 'yaxunit', // Usually your repo name.
  deploymentBranch: 'gh-pages',

  onBrokenLinks: 'throw',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'ru',
    locales: ['ru'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          routeBasePath: 'docs',
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/bia-technologies/yaxunit/blob/develop/documentation/',
          beforeDefaultRehypePlugins: [ 
            [ 
              rehypeShiki,
              {
                themes: {
                  light: "light-plus",
                  dark: "dark-plus"
                },
                langs: ["bsl", "json"],
              },
            ],
          ],
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
        blog: false,
      }),
    ]
  ],
  plugins: [
    [
      '@docusaurus/plugin-content-docs',
      {
        id: 'api',
        path: 'api',
        routeBasePath: 'api',
        sidebarPath: require.resolve('./sidebarsAPI.js'),
        // ... other options
      },
    ],
    [
      '@docusaurus/plugin-content-docs',
      {
        id: 'lessons',
        path: 'lessons',
        routeBasePath: 'lessons',
        sidebarPath: require.resolve('./sidebarsLessons.js'),
        // ... other options
      },
    ],
    [
      '@docusaurus/plugin-content-docs',
      {
        id: 'contributing',
        path: 'contributing',
        routeBasePath: 'contributing',
        sidebarPath: require.resolve('./sidebarsContributing.js'),
        // ... other options
      },
    ]
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      navbar: {
        title: 'YAx Unit',
        logo: {
          alt: 'YAxUnit Logo',
          src: 'img/logo.svg',
        },
        items: [
          {
            type: 'doc',
            docId: 'features/features',
            position: 'left',
            label: 'Описание',
          },
          {
            type: 'doc',
            docId: 'index',
            docsPluginId: 'lessons',
            position: 'left',
            label: 'Уроки',
          },
          {
            type: 'docSidebar',
            sidebarId: 'api',
            docsPluginId: 'api',
            position: 'left',
            label: 'API',
          },
          {
            type: 'doc',
            docId: 'index',
            docsPluginId: 'contributing',
            position: 'left',
            label: 'Руководство разработчика',
          },          
          {
            href: 'https://github.com/bia-technologies/yaxunit',
            label: 'bia-technologies/yaxunit',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Tutorial',
                to: '/docs/features',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Telegram',
                href: 'https://t.me/BIAOpenTools/12',
              }
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/bia-technologies/yaxunit',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} BIA Technologies, Inc. Built with Docusaurus.`,
      },

      docs: {
        sidebar: {
          hideable: true,
          autoCollapseCategories: true,
        },
      },
    }),

  markdown: {
    mermaid: true,
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  themes: ['@docusaurus/theme-mermaid', 
    ["@easyops-cn/docusaurus-search-local", {
      hashed: true,
      language: ["en", "ru"],
      indexBlog: false,
      indexDocs: true,
      docsRouteBasePath: ["docs", "api", 'contributing', 'lessons'],
      docsDir: ["docs", "api", 'contributing', 'lessons'],
      highlightSearchTermsOnTargetPage: true,
      hideSearchBarWithNoSearchContext: true,
    }]],
};

module.exports = config;
