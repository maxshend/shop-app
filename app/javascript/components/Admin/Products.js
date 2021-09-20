import React from "react";
import { useTranslation } from "react-i18next";

function Products() {
  const [t] = useTranslation();

  return (
    <table id="productsTable" className="w-full border-collapse border-2">
      <thead>
        <tr>
          <th>{t("admin.products.id")}</th>
          <th>{t("admin.products.name")}</th>
          <th>{t("admin.products.price")}</th>
          <th>{t("admin.products.quantity")}</th>
          <th>{t("admin.products.status")}</th>
          <th>{t("admin.products.active")}</th>
          <th>{t("admin.products.created_at")}</th>
        </tr>
      </thead>
      <tbody></tbody>
    </table>
  );
}

export default Products;
