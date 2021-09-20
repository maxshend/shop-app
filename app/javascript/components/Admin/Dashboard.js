import React, { Suspense } from "react";

import Spinner from "../Spinner";

import Header from "./Header";
import Products from "./Products";
import Filters from "./Filters";

function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <Filters />
      <Products />
    </Suspense>
  );
}

export default Dashboard;
