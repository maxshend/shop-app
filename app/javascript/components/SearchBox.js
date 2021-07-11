import React from "react";
import PropTypes from "prop-types";

class SearchBox extends React.Component {
  constructor(props) {
    super(props);

    this.changeHandler = this.changeHandler.bind(this);
    this.state = { query: "" };
  }

  changeHandler(event) {
    this.setState({query: event.target.value}, () => {
      this.props.searchCallback(this.state.query);
    });

    event.preventDefault();
  }

  render() {
    return (
      <div className="flex-none">
        <input
          type="text"
          value={this.state.query}
          className="w-full border-2 border-gray p-1"
          onChange={this.changeHandler}
          placeholder="Search..."
        />
      </div>
    );
  }
}

SearchBox.propTypes = {
  searchCallback: PropTypes.func
};

export default SearchBox;
