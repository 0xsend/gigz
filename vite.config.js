import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { visualizer } from "rollup-plugin-visualizer";
import { rescriptRelayVitePlugin } from "rescript-relay-router";
import vercel from 'vite-plugin-vercel';

export default defineConfig({
  plugins: [
    react(),
    rescriptRelayVitePlugin({
      autoScaffoldRenderers: true,
    }),
    vercel(),
  ],
  vercel: {
    rewrites: [{ "source": "/(.*)", "destination": "/client" }]
  },
  ssr: {
    noExternal: [
      // Work around the fact that rescript-relay is not yet an ESM module
      // which messes up imports on NodeJs.
      "rescript-relay",
    ],
  },
  build: {
    sourcemap: true,
    polyfillDynamicImport: false,
    target: "esnext",
    rollupOptions: {
      plugins: [visualizer()],
      output: {
        format: "esm",
        manualChunks: {
          react: ["react", "react-dom"],
          relay: ["react-relay", "relay-runtime"],
        },
      },
    },
  },
  // Prevent ReScript messages from being lost when we run all things at the same time.
  clearScreen: false,
});
