import "@hotwired/turbo-rails";
import { createRoot } from "react-dom/client";
import HelloReact from "./components/HelloReact.jsx";

document.addEventListener("turbo:load", () => {
  const el = document.getElementById("react-root");
  if (el && !el.dataset.mounted) {
    createRoot(el).render(<HelloReact name="Ca-Ching-App" />);
    el.dataset.mounted = "1";
  }
});
