import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import ViteRails from 'vite-plugin-rails';
import VuePlugin from '@vitejs/plugin-vue';
import { resolve } from 'path';

export default defineConfig({
  build: {
    assetsInlineLimit: 0,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules')) {
            return 'vendor';
          }
        },
      },
    },
  },
  plugins: [
    tailwindcss(),
    ViteRails({
      fullReload: {
        additionalPaths: ['config/routes.rb', 'app/views/**/*'],
      },
    }),
    VuePlugin(),
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'app/javascript'),
    },
  },
});
