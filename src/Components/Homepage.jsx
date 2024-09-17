import React, { useState } from "react";
import "./Homepage.css";
import Hometemplate from "../assets/mooresville.png";
import { ZipedSolution } from "./ZipedSolution";
const Homepage = () => {
  const [tenanturl, settenanturl] = useState("");
  const [sitename, setSitename] = useState("");
  const [buttonclick, setbuttonclick] = useState(false);
  const [disablebutton, setdisablebutton] = useState(false);
  const [error, seterror] = useState(false);
  const handleSubmit = (event) => {
    event.preventDefault(); // Prevent form submission
  };
  const handleChangeTenantUrl = (event) => {
    settenanturl(event.target.value);
  };
  const handleChange = (event) => {
    setSitename(event.target.value);
  };
  const handleClick = async () => {
    if (tenanturl && sitename !== "") {
      setbuttonclick(true);
      setdisablebutton(true);
    } else {
      seterror(true);
    }
  };

  return (
    <div class="container" id="container">
      <div class="form-container sign-in-container">
        {/* <button onClick={handleSiteCreate}>create site</button> */}
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            placeholder="Tenant name"
            onChange={handleChangeTenantUrl}
            value={tenanturl}
          />
          <input
            type="text"
            placeholder="Site name"
            onChange={handleChange}
            value={sitename}
          />
          {error ? (
            <div style={{ color: "red", fontSize: "11px" }}>
              Enter values in the input
            </div>
          ) : (
            ""
          )}
          {/* <a href="#">Forgot your password?</a> */}
          {/* {error && <div style={{ color: "red" }}>Enter the details</div>} */}
          <div style={{ marginTop: "20px" }}>
            {" "}
            <button
              className="generate-btn"
              disabled={disablebutton}
              onClick={handleClick}
            >
              Generate PnP Script
            </button>
          </div>
          <div style={{ marginTop: "20px" }}>
            {buttonclick && (
              <ZipedSolution tenanturl={tenanturl} sitename={sitename} />
            )}
          </div>

          {/* {isSiteExist && (
            <div style={{ color: "red" }}>
              Site with this name already exist
            </div>
          )} */}
        </form>
      </div>
      <div class="overlay-container">
        <div class="overlay">
          <div class="overlay-panel-top overlay-right">
            {/* <h1>Hello, {username.length > 0 ? username : "User"}!</h1> */}
            <img
              src={Hometemplate}
              alt="mooresville"
              style={{ width: "100%", height: "50%", objectFit: "contain" }}
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Homepage;
