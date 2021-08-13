import React, { useState, useEffect, Suspense } from "react";

import Products from './Products';
import SearchBox from './SearchBox';
import Spinner from './Spinner';
import Header from './Header';
import ProductStatusSelect from './ProductStatusSelect';

function Shop() {
  const [products, setProducts] = useState(null);
  const [queryParams, setQueryParams] = useState(new URLSearchParams());
  useEffect(() => {
    fetchProducts(setProducts, setError, queryParams);

    return;
  }, [queryParams]);
  const [error, setError] = useState(null);

  const filterByTitle = (query) => {
    setQueryParams((prevState) => {
      prevState.set("title", query);
      return new URLSearchParams(prevState.toString());
    });
  };

  const filterByStatus = (query) => {
    setQueryParams((prevState) => {
      prevState.set("status", query);
      return new URLSearchParams(prevState.toString());
    });
  };

  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
        <SearchBox searchCallback={filterByTitle} />
        <ProductStatusSelect searchCallback={filterByStatus} />
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
