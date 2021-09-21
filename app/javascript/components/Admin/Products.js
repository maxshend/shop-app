import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";

function Products() {
  const [t, i18n] = useTranslation();
  const [products, setProducts] = useState([]);
  useEffect(() => {
    fetchProducts(setProducts, setError, i18n.language);

    return;
  }, [i18n.language]);
  const [error, setError] = useState(null);
  
  if (error) {
    return ProductsError(t);
  }

  const productsList = products.map(product => {
    return (
      <tr key={product.id} className="productRow p-2 text-center">
        <td className="border-2">{product.id}</td>
        <td className="border-2">{product.title}</td>
        <td className="border-2">{product.price}</td>
        <td className="border-2">{product.quantity}</td>
        <td className="border-2">{product.status}</td>
        <td className="border-2">{product.active ? t("yes") : t("no")}</td>
        <td className="border-2">{product.created_at}</td>
        <td className="border-2 text-blue-500">
          <a href="">{t("delete")}</a>
        </td>
      </tr>
    );
  });

  return (
    <table id="productsTable" className="w-full border-collapse border-2 table-auto">
      <thead className="bg-gray-200">
        <tr className="text-center">
          <th>{t("admin.products.id")}</th>
          <th>{t("admin.products.name")}</th>
          <th>{t("admin.products.price")}</th>
          <th>{t("admin.products.quantity")}</th>
          <th>{t("admin.products.status")}</th>
          <th>{t("admin.products.active")}</th>
          <th>{t("admin.products.created_at")}</th>
          <th></th>
        </tr>
      </thead>
      <tbody>{productsList}</tbody>
    </table>
  );
}

function fetchProducts(setProducts, setError, language, params = "") {
  fetch(`/api/admin/products?locale=${language}&${params}`)
  .then(res => res.json())
  .then(
    (res) => {
      setProducts(res.products);
    },
    (err) => {
      setError(err)
    }
  );
}

function ProductsError(t) {
  return (
    <div className="text-center">
      <span className="font-bold text-red-400">{t("errors.products.load")}</span>
    </div>
  );
}

export default Products;
