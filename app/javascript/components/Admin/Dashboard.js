import React, { Suspense } from "react";

import Spinner from "../Spinner";

import Header from "./Header";
import Products from "./Products";
import Filters from "./Filters";

function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <div className="p-3">
        <Filters />
        <Products />
      </div>
    </Suspense>
  );
}

export default Dashboard;
