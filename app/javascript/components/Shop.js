import React, { Suspense } from "react";

import Spinner from "./Spinner";
import Header from "./Header";
import Showcase from "./Showcase";

function Shop() {
  return (
    <Suspense fallback={<Spinner />}>
      <Header />
      <Showcase />
    </Suspense>
  );
}

export default Shop;
