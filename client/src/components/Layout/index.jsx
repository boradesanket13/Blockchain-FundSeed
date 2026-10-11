import { ToastContainer } from "react-toastify";

import Topbar from "./Topbar";
import Sidebar from "./Sidebar";
import Footer from "./Footer";

const Layout = ({ children }) => {
  return (
    <div className="w-full flex my-2 gap-2">
      <Sidebar />
      <div className="mx-auto w-full lg:max-w-[800px] xl:max-w-[1200px] px-4 pb-2">
        <Topbar />
        <main>{children}</main>
        <Footer />
        <ToastContainer
          position="bottom-center"
          autoClose={3000}
          hideProgressBar={true}
          closeOnClick={true}
          pauseOnHover={true}
          draggable={false}
          progress={undefined}
          theme="dark"
          toastClassName="bg-neutral-800"
          className="w-full max-w-[400px]"
        />
      </div>
    </div>
  );
};

export default Layout;
