import "@hotwired/turbo-rails";
import { createRoot } from "react-dom/client";
import HelloReact from "./components/HelloReact.jsx";
import ProductsList from "./components/ProductsList.jsx";

document.addEventListener("turbo:load", () => {
  const el = document.getElementById("react-root");
  if (el && !el.dataset.mounted) {
    createRoot(el).render(<HelloReact name="Ca-Ching-App" />);
    hello.dataset.mounted = "1";
  }

  const pl = document.getElementById("products-react");
  if (pl && !pl.dataset.mounted) {
    createRoot(pl).render(<ProductsList />);
    pl.dataset.mounted = "1";
  }
});
