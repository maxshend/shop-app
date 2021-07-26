import React from "react"
import PropTypes from "prop-types"

import Product from './Product';
import SearchBox from './SearchBox';

class Products extends React.Component {
  constructor(props) {
    super(props);

    this.state = { products: [] };
    this.filterProducts = this.filterProducts.bind(this);
  }

  fetchProducts(params) {
    fetch(`/api/v1/products?${params}`)
    .then(res => res.json())
    .then(
      (res) => {
        this.setState({products: res.products});
      },
      (err) => {
        console.log('Error: ', err);
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
    const productsList = this.state.products.map(product => {
      return (
        <Product
          key={product.id}
          id={product.id}
          title={product.title}
          poster={product.poster}
        />
      );
    });

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
