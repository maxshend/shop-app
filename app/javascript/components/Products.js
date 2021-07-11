import React from "react"
import PropTypes from "prop-types"

import Product from './Product';
import SearchBox from './SearchBox';

class Products extends React.Component {
  constructor(props) {
    super(props);

    this.filterProducts = this.filterProducts.bind(this);
  }

  filterProducts(query) {
    console.log('Filter products by: ', query);
  }

  render() {
    const productsList = JSON.parse(this.props.products).products.map(product => {
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
