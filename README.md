# YunchoHang's Cybersecurity Blog

A personal cybersecurity blog built with Hugo and the Blowfish theme, featuring writeups, projects, and insights from my security journey.

## 🚀 Features

- **Modern Design**: Clean, responsive design using the Blowfish theme
- **External Content Integration**: Seamless linking to Medium articles and GitHub projects
- **SEO Optimized**: Proper meta tags, sitemap, and structured data
- **Fast Performance**: Static site generation with optimized assets
- **Dark Mode**: Automatic dark/light mode support

## 📁 Project Structure

```
YunchoHang/
├── content/           # Blog posts and pages
│   ├── posts/        # Blog articles
│   ├── projects/     # Project showcases
│   └── about/        # About page
├── assets/           # Images and static assets
├── layouts/          # Custom layout templates
├── themes/           # Hugo themes (Blowfish)
└── public/           # Generated static site (gitignored)
```

## 🛠️ Local Development

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) (v0.148.2 or later)
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/YunchoHang/YunchoHang.git
   cd YunchoHang
   ```

2. **Install theme submodule**
   ```bash
   git submodule update --init --recursive
   ```

3. **Run development server**
   ```bash
   hugo server --disableFastRender
   ```

4. **Build for production**
   ```bash
   hugo --gc --minify
   ```

## 🚀 Deployment

### GitHub Pages (Recommended)

This site is configured for automatic deployment to GitHub Pages:

1. **Push to main branch**
   ```bash
   git add -A
   git commit -m "Update site content"
   git push origin main
   ```

2. **GitHub Actions will automatically:**
   - Build the site with Hugo
   - Deploy to GitHub Pages
   - Update your site at `https://YunchoHang.github.io`

### Manual Deployment

If you prefer manual deployment:

1. **Build the site**
   ```bash
   hugo --gc --minify
   ```

2. **Deploy to your hosting provider**
   - Upload the `public/` directory contents
   - Configure your domain if needed

## 📝 Content Management

### Adding Blog Posts

1. Create a new markdown file in `content/posts/`
2. Use the following front matter template:

```yaml
---
title: "Your Post Title"
description: "Brief description of the post"
date: 2024-01-01
tags: ["tag1", "tag2"]
categories: ["category"]
featured_image: "/images/your-image.jpg"
externalUrl: "https://medium.com/@your-username/your-article"  # Optional
---
```

### Adding Projects

1. Create a new markdown file in `content/projects/`
2. Use similar front matter as blog posts
3. Set `externalUrl` to your GitHub repository or project page

### External Content

For content hosted on external platforms (Medium, GitHub, etc.):
- Set the `externalUrl` parameter in front matter
- The site will display a redirect page with a link to the external content
- This keeps your site organized while leveraging external platforms

## 🎨 Customization

### Theme Configuration

The site uses the Blowfish theme with custom configurations in `hugo.toml`:

- **Author Information**: Update in `[params.author]` section
- **Site Colors**: Modify CSS variables in theme assets
- **Navigation**: Configure menu items in `[menu]` section

### Custom Layouts

Custom layouts are in the `layouts/` directory:
- `layouts/posts/single.html`: Blog post template
- `layouts/partials/article-link/card.html`: Article card template

## 🔧 Troubleshooting

### Common Issues

1. **Theme not loading**
   ```bash
   git submodule update --init --recursive
   ```

2. **Build errors**
   ```bash
   hugo --gc --minify --printPathWarnings
   ```

3. **Images not displaying**
   - Ensure images are in `assets/images/`
   - Use relative paths in front matter

### Performance Optimization

- Images are automatically optimized by Hugo
- CSS and JS are minified in production builds
- Static assets are cached with fingerprinting

## 📄 License

This project is for educational and personal use. Please respect the licenses of any external content linked from this site.

## 🤝 Contributing

While this is a personal blog, suggestions and feedback are welcome:
- Open issues for bugs or improvements
- Fork the repository for major changes
- Follow security best practices when contributing

## 📞 Contact

- **GitHub**: [@YunchoHang](https://github.com/YunchoHang)
- **LinkedIn**: [yunchohang](https://linkedin.com/in/yunchohang)
- **Medium**: [@thatguysbroke](https://medium.com/@thatguysbroke)
- **Discord**: thatguysbroke

---

*Built with ❤️ using Hugo and the Blowfish theme*
