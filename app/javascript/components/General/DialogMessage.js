import React, { useEffect, useState } from "react";
import PropTypes from "prop-types";
import { useTranslation } from "react-i18next";
import { Dialog } from "@headlessui/react";

function DialogMessage(props) {
  const [t, i18n] = useTranslation();
  let [isOpen, setIsOpen] = useState(true);
  useEffect(() => {
    setIsOpen(!!props.text);

    return;
  }, [props.text, i18n.language]);

  const closeDialog = () => {
    props.onClose();
    setIsOpen(false);
  };

  return (
    <Dialog
      open={isOpen}
      onClose={() => setIsOpen(false)}
      className="fixed z-10 inset-0 overflow-y-auto"
    >
      <div className="flex items-center justify-center min-h-screen">
        <Dialog.Overlay className="fixed inset-0 bg-black opacity-30" />
        <div className="relative bg-white rounded max-w-sm mx-auto p-2">
          <Dialog.Title>{props.text}</Dialog.Title>
          <br/>
          <button onClick={closeDialog}>{t("close")}</button>
        </div>
      </div>
    </Dialog>
  )
}

DialogMessage.propTypes = {
  text: PropTypes.string,
  onClose: PropTypes.func,
};

export default DialogMessage;
