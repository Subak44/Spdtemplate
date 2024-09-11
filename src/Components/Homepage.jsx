import React, { useState } from "react";
import "./Homepage.css";
import Hometemplate from "../assets/mooresville.png";
import { ZipedSolution } from "./ZipedSolution";
const Homepage = () => {
  const [tenanturl, settenanturl] = useState("");
  const [sitename, setSitename] = useState("");
  const [buttonclick, setbuttonclick] = useState(false);
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
    console.log("clicked");
    if (tenanturl && sitename !== "") {
      setbuttonclick(true);
    } else {
      seterror(true);
    }
  };
  console.log(tenanturl);

  return (
    <div class="container" id="container">
      <div class="form-container sign-in-container">
        {/* <button onClick={handleSiteCreate}>create site</button> */}
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            placeholder="tenant name"
            onChange={handleChangeTenantUrl}
            value={tenanturl}
          />
          <input
            type="text"
            placeholder="site name"
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
            <button onClick={handleClick}>Create DMS Site</button>
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
              style={{ width: "100%", height: "50%", objectFit: "contain" }}
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Homepage;
