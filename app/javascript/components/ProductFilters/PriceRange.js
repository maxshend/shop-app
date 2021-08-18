import React from "react";
import PropTypes from "prop-types";
import { useTranslation } from "react-i18next";

import NumericFilter from "../General/NumericFilter";

function PriceRange(props) {
  const [t] = useTranslation();

  return (
    <div>
      <NumericFilter
        className="flex flex-col"
        label={t('min_price')}
        name="minPrice"
        searchCallback={props.searchCallback}
      />
      <NumericFilter
        className="flex flex-col"
        label={t('max_price')}
        name="maxPrice"
        searchCallback={props.searchCallback}
      />
    </div>
  );
}

PriceRange.propTypes = {
  searchCallback: PropTypes.func
};

export default PriceRange;
