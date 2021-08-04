import React, { useState, useEffect } from "react"

import Product from './Product';
import SearchBox from './SearchBox';

function Products() {
  const [products, updateProducts] = useState([]);
  const [error, updateError] = useState(null);
  useEffect(() => {
    fetchProducts(updateProducts, updateError);

    return;
  }, []);

  let productsList = null;
  const filterProducts = (query) => {
    const params = new URLSearchParams({
      title: query
    });

    fetchProducts(updateProducts, updateError, params);
  };

  if (error) {
    productsList = <ProductsError />
  } else if (products.length === 0) {
    productsList = <ProductsNotFound />
  } else {
    productsList = products.map(product => {
      return (
        <Product
          key={product.id}
          id={product.id}
          title={product.title}
          poster={product.poster}
        />
      );
    });
  }

  return (
    <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
      <SearchBox searchCallback={filterProducts} />
      {productsList}
    </div>
  );
}

function ProductsNotFound() {
  return (
    <div className="text-center">
      <span className="text-gray-500">Products not found</span>
    </div>
  );
}

function ProductsError() {
  return (
    <div className="text-center">
      <span className="font-bold text-red-400">Cannot load products</span>
    </div>
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

export default Products;
