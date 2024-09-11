import React, { useState } from "react";
import { FaDownload } from "react-icons/fa";
import JSZip from "jszip";
import FileSaver from "file-saver";
export const ZipedSolution = (props) => {
  // const [SiteUrl, setSiteUrl] = useState("");
  // const [environemnt, setenvironemnt] = useState([""]);
  // console.log(props);
  async function readfile(filepath) {
    let url2 = filepath;
    let file1 = await fetch(url2)
      .then((r) => r.text())
      .then((t) => {
        return t;
      });
    return file1;
  }
  async function readimgfile(filepath) {
    let url2 = filepath;
    let file1 = await fetch(url2)
      .then((r) => r.blob()) // Fetch the file as a Blob
      .then((blob) => {
        return blob; // Return the Blob object
      });
    return file1;
  }
  async function zipfiles() {
    // console.log("clicked");

    let packagefolder = "Template";
    let file1 = "Template-Automation_Script.ps1";
    let file2 = "announce1.jpg";
    let file3 = "announce2.jpg";
    let file4 = "announce3.jpg";
    let file5 = "announcements-webpart.sppkg";
    let file6 = "breaking-news.sppkg";
    let file7 = "faqs-webpart.sppkg";
    let file8 = "news.sppkg";
    let file9 = "quicklinks-webpart.sppkg";
    let file10 = "react-rssreader.sppkg";
    let file11 = "spfx-msgraph-peoplesearch.sppkg";
    let file12 = "upcomingevents-calendar.sppkg";
    let file13 = "admin.jpg";
    let qfile1 = "contract-white.png";
    let qfile2 = "contract.png";
    let qfile3 = "facility-white.png";
    let qfile4 = "facility.png";
    let qfile5 = "form-white.png";
    let qfile6 = "form.png";
    let qfile7 = "gps-white.png";
    let qfile8 = "gps.png";
    let qfile9 = "mail-white.png";
    let qfile10 = "mail.png";
    let qfile11 = "service-white.png";
    let qfile12 = "service.png";

    let templatepath = "/templates/Template-Automation_Script.ps1";
    let imgfile1 = "/templates/AnnouncementImages/" + file2;
    let imgfile2 = "/templates/AnnouncementImages/" + file3;
    let imgfile3 = "/templates/AnnouncementImages/" + file4;
    let imgfile4 = "/templates/admin-page-image/" + file13;
    let sppkgfile1 = "/templates/sppkg/" + file5;
    let sppkgfile2 = "/templates/sppkg/" + file6;
    let sppkgfile3 = "/templates/sppkg/" + file7;
    let sppkgfile4 = "/templates/sppkg/" + file8;
    let sppkgfile5 = "/templates/sppkg/" + file9;
    let sppkgfile6 = "/templates/sppkg/" + file10;
    let sppkgfile7 = "/templates/sppkg/" + file11;
    let sppkgfile8 = "/templates/sppkg/" + file12;
    let qlinksfile1 = "/templates/QuicklinksIcons/" + qfile1;
    let qlinksfile2 = "/templates/QuicklinksIcons/" + qfile2;
    let qlinksfile3 = "/templates/QuicklinksIcons/" + qfile3;
    let qlinksfile4 = "/templates/QuicklinksIcons/" + qfile4;
    let qlinksfile5 = "/templates/QuicklinksIcons/" + qfile5;
    let qlinksfile6 = "/templates/QuicklinksIcons/" + qfile6;
    let qlinksfile7 = "/templates/QuicklinksIcons/" + qfile7;
    let qlinksfile8 = "/templates/QuicklinksIcons/" + qfile8;
    let qlinksfile9 = "/templates/QuicklinksIcons/" + qfile9;
    let qlinksfile10 = "/templates/QuicklinksIcons/" + qfile10;
    let qlinksfile11 = "/templates/QuicklinksIcons/" + qfile11;
    let qlinksfile12 = "/templates/QuicklinksIcons/" + qfile12;

    // let xmlfile2 = templatepath + "/" + file2;
    // let xmlfile3 = templatepath + "/" + file3;

    let wfile1 = templatepath;
    let wfile2 = imgfile1;
    let wfile3 = imgfile2;
    let wfile4 = imgfile3;
    let wfile5 = imgfile4;
    let sfile1 = sppkgfile1;
    let sfile2 = sppkgfile2;
    let sfile3 = sppkgfile3;
    let sfile4 = sppkgfile4;
    let sfile5 = sppkgfile5;
    let sfile6 = sppkgfile6;
    let sfile7 = sppkgfile7;
    let sfile8 = sppkgfile8;
    let qlfile1 = qlinksfile1;
    let qlfile2 = qlinksfile2;
    let qlfile3 = qlinksfile3;
    let qlfile4 = qlinksfile4;
    let qlfile5 = qlinksfile5;
    let qlfile6 = qlinksfile6;
    let qlfile7 = qlinksfile7;
    let qlfile8 = qlinksfile8;
    let qlfile9 = qlinksfile9;
    let qlfile10 = qlinksfile10;
    let qlfile11 = qlinksfile11;
    let qlfile12 = qlinksfile12;

    let contentfile1 = await readfile(wfile1);
    let contentfile2 = await readimgfile(wfile2);
    let contentfile3 = await readimgfile(wfile3);
    let contentfile4 = await readimgfile(wfile4);
    let contentfile5 = await readfile(sfile1);
    let contentfile6 = await readfile(sfile2);
    let contentfile7 = await readfile(sfile3);
    let contentfile8 = await readfile(sfile4);
    let contentfile9 = await readfile(sfile5);
    let contentfile10 = await readfile(sfile6);
    let contentfile11 = await readfile(sfile7);
    let contentfile12 = await readfile(sfile8);
    let contentfile13 = await readimgfile(wfile5);
    let contentfile14 = await readimgfile(qlfile1);
    let contentfile15 = await readimgfile(qlfile2);
    let contentfile16 = await readimgfile(qlfile3);
    let contentfile17 = await readimgfile(qlfile4);
    let contentfile18 = await readimgfile(qlfile5);
    let contentfile19 = await readimgfile(qlfile6);
    let contentfile20 = await readimgfile(qlfile7);
    let contentfile21 = await readimgfile(qlfile8);
    let contentfile22 = await readimgfile(qlfile9);
    let contentfile23 = await readimgfile(qlfile10);
    let contentfile24 = await readimgfile(qlfile11);
    let contentfile25 = await readimgfile(qlfile12);

    const zip = new JSZip();
    const secondfolder = zip.folder("AnnouncementImages");
    contentfile1 = contentfile1.replaceAll("<sitename>", `${props.sitename}`);
    contentfile1 = contentfile1.replaceAll(
      "<tenantname>",
      `${props.tenanturl}`
    );

    zip.file(file1, contentfile1);
    secondfolder.file(file2, contentfile2);
    secondfolder.file(file3, contentfile3);
    secondfolder.file(file4, contentfile4);
    const thirdfolder = zip.folder("sppkg");
    thirdfolder.file(file5, contentfile5);
    thirdfolder.file(file6, contentfile6);
    thirdfolder.file(file7, contentfile7);
    thirdfolder.file(file8, contentfile8);
    thirdfolder.file(file9, contentfile9);
    thirdfolder.file(file10, contentfile10);
    thirdfolder.file(file11, contentfile11);
    thirdfolder.file(file12, contentfile12);
    const fourthfolder = zip.folder("admin-page-image");
    fourthfolder.file(file13, contentfile13);
    const fifthfolder = zip.folder("QuicklinksIcons");
    fifthfolder.file(qfile1, contentfile14);
    fifthfolder.file(qfile2, contentfile15);
    fifthfolder.file(qfile3, contentfile16);
    fifthfolder.file(qfile4, contentfile17);
    fifthfolder.file(qfile5, contentfile18);
    fifthfolder.file(qfile6, contentfile19);
    fifthfolder.file(qfile7, contentfile20);
    fifthfolder.file(qfile8, contentfile21);
    fifthfolder.file(qfile9, contentfile22);
    fifthfolder.file(qfile10, contentfile23);
    fifthfolder.file(qfile11, contentfile24);
    fifthfolder.file(qfile12, contentfile25);

    zip.generateAsync({ type: "blob" }).then(function (content) {
      FileSaver.saveAs(content, "SPDTemplate.zip");
    });
  }
  return (
    <>
      <button
        onClick={zipfiles}
        style={{
          paddingTop: "9px",
          paddingBottom: "9px",
          paddingRight: "15px",
          paddingLeft: "15px",
          fontSize: "12px",
        }}
      >
        <span style={{ marginRight: "7px" }}>
          <FaDownload />
        </span>
        SPD Template
      </button>
    </>
  );
};
