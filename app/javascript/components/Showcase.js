import React, { useState, useEffect, Suspense } from "react";
import { useTranslation } from "react-i18next";

import Products from './Products';
import Spinner from './Spinner';
import ProductStatusSelect from './ProductFilters/ProductStatusSelect';
import CategorySelect from './ProductFilters/CategorySelect';
import SearchBox from './ProductFilters/SearchBox';
import PriceRange from './ProductFilters/PriceRange';

const titleParam = "title";
const statusParam = "status";
const minPriceParam = "min_price";
const maxPriceParam = "max_price";
const categoriesParam = "categories";

function Showcase() {
  const [products, setProducts] = useState(null);
  const [queryParams, setQueryParams] = useState(new URLSearchParams());
  const [_, i18n] = useTranslation();
  useEffect(() => {
    fetchProducts(setProducts, setError, queryParams, i18n.language);

    return;
  }, [queryParams, i18n.language]);
  const [error, setError] = useState(null);

  const filterByTitle = (query) => {
    setQueryParams((prevState) => {
      prevState.set(titleParam, query);
      return new URLSearchParams(prevState.toString());
    });
  };

  const filterByStatus = (query) => {
    setQueryParams((prevState) => {
      prevState.set(statusParam, query);

      return new URLSearchParams(prevState.toString());
    });
  };

  const filterByPrice = (query) => {
    setQueryParams((prevState) => {
      if (query.hasOwnProperty("minPrice")) {
        if (query.minPrice === "") {
          prevState.delete(minPriceParam);
        } else {
          prevState.set(minPriceParam, (parseFloat(query.minPrice) || 0) * 100);
        }
      } else if (query.hasOwnProperty("maxPrice")) {
        if (query.maxPrice === "") {
          prevState.delete(maxPriceParam);
        } else {
          prevState.set(maxPriceParam, (parseFloat(query.maxPrice) || 0) * 100);
        }
      }

      return new URLSearchParams(prevState.toString());
    });
  };

  const filterByCategory = (query) => {
    setQueryParams((prevState) => {
      prevState.delete(`${categoriesParam}[]`);
      query.forEach((q) => prevState.append(`${categoriesParam}[]`, parseInt(q)));

      return new URLSearchParams(prevState.toString());
    });
  };

  return (
    <Suspense fallback={<Spinner />}>
      <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
        <SearchBox searchCallback={filterByTitle} />
        <ProductStatusSelect searchCallback={filterByStatus} />
        <CategorySelect searchCallback={filterByCategory} />
        <PriceRange searchCallback={filterByPrice} />
        <Products products={products} error={error} />
      </div>
    </Suspense>
  );
}

function fetchProducts(setProducts, setError, params = '', language) {
  fetch(`/api/v1/products?locale=${language}&${params}`)
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

export default Showcase;
