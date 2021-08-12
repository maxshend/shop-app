import React, { useState, useEffect, Suspense } from "react";

import Products from './Products';
import SearchBox from './SearchBox';
import Spinner from './Spinner';
import Header from './Header';
import ProductStatusSelect from './ProductStatusSelect';

function Shop() {
  const [products, setProducts] = useState(null);
  useEffect(() => {
    fetchProducts(setProducts, setError);

    return;
  }, []);
  const [error, setError] = useState(null);

  const filterProducts = (query) => {
    const params = new URLSearchParams({
      title: query
    });

    fetchProducts(setProducts, setError, params);
  };

  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
        <SearchBox searchCallback={filterProducts} />
        <ProductStatusSelect />
        <Products products={products} error={error} />
      </div>
    </Suspense>
  );
}

function fetchProducts(setProducts, setError, params = '') {
  fetch(`/api/v1/products?${params}`)
  .then(res => res.json())
  .then(
    (res) => {
      setProducts(res.products);
    },
    (err) => {
      setError(err);
    }
  );
}

export default Shop;
