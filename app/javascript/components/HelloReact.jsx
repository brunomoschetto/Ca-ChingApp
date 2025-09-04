export default function HelloReact({ name = "React" }) {
  return (
    <div className="card mb-3">
      <div className="card-header bg-custom-amber text-custom-dark">
        <b>Hello from {name}</b>
      </div>
      <div className="card-body">
        <p>Este bloque está renderizado por React.</p>
      </div>
    </div>
  );
}
