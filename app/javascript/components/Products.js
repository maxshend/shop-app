import React from "react";
import PropTypes from "prop-types";
import { useTranslation } from "react-i18next";

import Product from "./Product";
import Spinner from "./Spinner";

function Products(props) {
  let productsList = null;

  if (props.error) {
    productsList = <ProductsError />
  } else if (props.products === null) {
    productsList = <Spinner />;
  } else if (props.products.length === 0) {
    productsList = <ProductsNotFound />
  } else {
    productsList = props.products.map(product => {
      return (
        <Product
          key={product.id}
          id={product.id}
          title={product.title}
          poster={product.poster}
          price={product.price}
          old_price={product.old_price}
          status={product.status}
        />
      );
    });
  }

  return productsList;
}

Products.propTypes = {
  error: PropTypes.object,
  products: PropTypes.array
};

function ProductsNotFound() {
  const [t] = useTranslation();

  return (
    <div className="text-center">
      <span className="text-gray-500">{t("errors.products.not_found")}</span>
    </div>
  );
}

function ProductsError() {
  const [t] = useTranslation();

  return (
    <div className="text-center">
      <span className="font-bold text-red-400">{t("errors.products.load")}</span>
    </div>
  );
}

export default Products;
