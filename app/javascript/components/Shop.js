import React, { useState, useEffect, Suspense } from "react";

import Products from './Products';
import SearchBox from './SearchBox';
import Spinner from './Spinner';
import Header from './Header';

function Shop() {
  const [products, updateProducts] = useState(null);
  useEffect(() => {
    fetchProducts(updateProducts, updateError);

    return;
  }, []);
  const [error, updateError] = useState(null);

  const filterProducts = (query) => {
    const params = new URLSearchParams({
      title: query
    });

    fetchProducts(updateProducts, updateError, params);
  };

  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
        <SearchBox searchCallback={filterProducts} />
        <Products products={products} error={error} />
      </div>
    </Suspense>
  );
}

function fetchProducts(updateProducts, updateError, params = '') {
  fetch(`/api/v1/products?${params}`)
  .then(res => res.json())
  .then(
    (res) => {
      updateProducts(res.products);
    },
    (err) => {
      updateError(err);
    }
  );
}

export default Shop;
