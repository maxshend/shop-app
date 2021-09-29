import React, { Suspense } from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

import Spinner from "../Spinner";

import Header from "./Header";
import Products from "./Products";
import AdminUsers from "./AdminUsers";

function Dashboard() {
  return (
    <Router>
      <Suspense fallback={<Spinner />}>
        <Header />
        <div className="p-3">
          <Switch>
            <Route exact path="/admin">
              <Products />
            </Route>
            <Route path="/admin/admin_users">
              <AdminUsers />
            </Route>
            <Route path="/admin/products">
              <Products />
            </Route>
          </Switch>
        </div>
      </Suspense>
    </Router>
  );
}

export default Dashboard;
