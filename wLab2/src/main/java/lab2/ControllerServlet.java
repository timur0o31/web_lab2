package lab2;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getParameter("x")!=null && req.getParameter("y")!=null && req.getParameter("r")!=null) {
            RequestDispatcher rd = req.getRequestDispatcher("/areaCheck");
            rd.forward(req, res);
        }else{
            req.getRequestDispatcher("/index.jsp").forward(req, res);
        }
    }
}
