<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Login</title>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");
      body {
        background: url("images/file.jpg") no-repeat center center fixed;
        background-size: cover;
        font-family: Poppins;
      }
      div.container {
        margin-top: 5%;
        width: 35%;
      }
    </style>
  </head>
  <body style="background-image: url(images/file.jpg);">
    <main>
      <div
        class="container"
        style="
          background: rgba(255, 255, 255, 0.1);
          border-radius: 16px;
          box-shadow: 0 8px 32px 0 rgba(0, 0, 3, 0.37);
          backdrop-filter: blur(20px);
          -webkit-backdrop-filter: blur(20px);
          border: 1px solid rgba(255, 255, 255, 0.29);
          padding: 20px;
          text-align: center;
        "
      >
        <img
          src="images/tj.jpg"
          class="rounded-circle"
          alt=""
          height="50"
          width="50"
        />
        <div
          class="mt-2"
          style="
            font-family: Poppins;
            font-weight: 600;
            font-size: 20px;
            color: white;
          "
        >
          <span>Sign up with us</span>
        </div>
        <form action="Register" method="post">
          <div class="form-floating mb-3 mt-3">
            <input
              type="mail"
              class="form-control"
              name="mail"
              id="formId1"
              placeholder="Enter your username"
            />
            <label for="formId1">Mail ID</label>
          </div>
          <div class="form-floating mb-3">
            <input
              type="text"
              class="form-control"
              name="name"
              id="formId2"
              placeholder="Enter your name"
            />
            <label for="formId2">Name</label>
          </div>
          <div class="form-floating mb-3 mt-4">
            <input
              type="password"
              class="form-control"
              name="pword"
              id="password"
              placeholder="Enter your password"
            />
            <label for="password">Password</label>
          </div>
          <div class="form-floating mb-3 mt-4">
            <input
              type="password"
              class="form-control"
              name="confirmPassword"
              id="confirmPassword"
              placeholder="Confirm your password"
            />
            <label for="confirmPassword">Confirm Password</label>
          </div>
          <div class="form-floating mb-3 mt-4">
            <select
              class="form-select"
              id="userRole"
              name="role"
              aria-label="Select user role"
            >
              <option selected disabled>Select Role</option>
              <option >Regular</option>
            </select>
            <label for="userRole">User Role</label>
          </div>
          <div>
            <button
              type="submit"
              class="btn btn-primary col-12"
              style="font-family: Poppins; font-weight: 600; font-size: 20px"
            >
              Sign Up
            </button>
          </div>
          <div
            class="mt-3"
            style="
              font-family: Poppins;
              font-weight: 500;
              font-size: 17px;
              color: white;
            "
          >
            <span style="color: white"
              >Already have an Account ?
              <a href="login.jsp" style="color: rgb(0, 0, 0)">Sign in</a></span
            >
          </div>
        </form>
      </div>
    </main>
    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
    