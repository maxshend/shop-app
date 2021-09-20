import React from "react";

import Header from "./Header";
import Products from "./Products";
import Filters from "./Filters";

function Dashboard() {
  return (
    <div>
      <Header />
      <Filters />
      <Products />
    </div>
  );
}

export default Dashboard;
