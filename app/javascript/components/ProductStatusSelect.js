import React, { useEffect, useState } from "react";

function ProductStatusSelect() {
  const [status, setStatus] = useState("");
  const [error, setError] = useState(null);
  const [statuses, setStatuses] = useState([]);

  useEffect(() => {
    fetchStatuses(setStatuses, setError);

    return;
  }, []);

  function changeHandler(event) {
    event.preventDefault();
    setStatus(event.target.value);
  }

  if (error) {
    return null;
  }

  const values = statuses.map((status) => {
    return <option key={status.key} value={status.key}>{status.name}</option>
  });

  return (
    <select value={status} onChange={changeHandler}>
      {values}
    </select>
  );
}

function fetchStatuses(setStatuses, setError) {
  fetch('/api/v1/products/statuses')
  .then(res => res.json())
  .then(
    (res) => {
      setStatuses(res.statuses)
    },
    (err) => {
      setError(err);
    }
  );
}

export default ProductStatusSelect;
