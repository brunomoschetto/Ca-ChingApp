import { useEffect, useState } from "react";

export default function ProductsList() {
  const [products, setProducts] = useState([]);
  const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

  useEffect(() => {
    fetch("/products.json", { headers: { Accept: "application/json" } })
      .then(r => r.json())
      .then(setProducts)
      .catch(() => setProducts([]));
  }, []);

  return (
    <div className="card mb-4 products-card">
      <div className="card-header bg-custom-amber text-custom-dark">
        <h2 className="h5 mb-0">Products (React)</h2>
      </div>
      <div className="card-body p-0">
        <ul className="list-group list-group-flush">
          {products.map(p => (
            <li key={p.id} className="list-group-item d-flex justify-content-between align-items-center">
              <div className="d-flex align-items-center">
                <span className="fw-bold me-2">{p.name}</span>
                <span className="text-success me-2">€{Number(p.price).toFixed(2)}</span>
                {p.promo === "bogof" && <span className="badge bg-success">Buy 1 Get 1</span>}
                {p.promo === "bulk_price" && <span className="badge bg-info">Bulk price from 3</span>}
                {p.promo === "bulk_percentage" && <span className="badge bg-info">Bulk discount from 3</span>}
              </div>
              <form action="/cart/add_product" method="post" data-turbo="true">
                <input type="hidden" name="authenticity_token" value={token} />
                <input type="hidden" name="product_id" value={p.id} />
                <button type="submit" className="btn btn-sm border-0 bg-custom-amber text-custom-dark">
                  Add product to cart
                </button>
              </form>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
