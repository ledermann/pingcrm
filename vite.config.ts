import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import FullReload from 'vite-plugin-full-reload';
import Vue2Plugin from '@vitejs/plugin-vue2';
import { brotliCompressSync } from 'zlib';
import gzipPlugin from 'rollup-plugin-gzip';

export default defineConfig({
  optimizeDeps: {
    include: ['@inertiajs/inertia'],
  },
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*']),
    Vue2Plugin(),
    // Create gzip copies of relevant assets
    gzipPlugin(),
    // Create brotli copies of relevant assets
    gzipPlugin({
      customCompression: (content) => brotliCompressSync(Buffer.from(content)),
      fileName: '.br',
    }),
  ],
});
