import React from "react"
import PropTypes from "prop-types"

import Product from './Product';
import SearchBox from './SearchBox';

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

class Products extends React.Component {
  constructor(props) {
    super(props);

    this.state = { error: null, products: [] };
    this.filterProducts = this.filterProducts.bind(this);
  }

  fetchProducts(params = '') {
    fetch(`/api/v1/products?${params}`)
    .then(res => res.json())
    .then(
      (res) => {
        this.setState({products: res.products});
      },
      (err) => {
        this.setState({error: err});
      }
    );
  }

  filterProducts(query) {
    const params = new URLSearchParams({
      title: query
    });

    this.fetchProducts(params)
  }

  componentDidMount() {
    this.fetchProducts();
  }

  render() {
    let productsList = null;

    if (this.state.error) {
      productsList = <ProductsError />
    } else if (this.state.products.length === 0) {
      productsList = <ProductsNotFound />
    } else {
      productsList = this.state.products.map(product => {
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
        <SearchBox searchCallback={this.filterProducts} />
        {productsList}
      </div>
    );
  }
}

Products.propTypes = {
  products: PropTypes.string
};

export default Products;
