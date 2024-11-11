package lab2;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/areaCheck")
public class AreaCheckServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("AreaCheckServlet получила переданный запрос от Controller");
        ServletContext context = getServletContext();
        List<String> requests = (List<String>) context.getAttribute("requests");
        if (requests == null) {
            requests = new ArrayList<>();
        }
        String x = req.getParameter("x");
        String y = String.valueOf(Double.parseDouble(req.getParameter("y")));
        String r = req.getParameter("r");
        req.setAttribute("x", x);
        req.setAttribute("y", y);
        req.setAttribute("r", r);
        long startTime = System.nanoTime();
        Validator validator = new Validator();
        if (validator.validate(x,y,r)){
            long time = System.nanoTime();
            if (check(x,y,r)){
                //System.out.println("Попал!");
                req.setAttribute("result","hit");
            }else{
                //System.out.println("мисснул");
                req.setAttribute("result","miss");
            }
            req.setAttribute("time",time-startTime);
        }else{
            req.setAttribute("result","error");
        }
        long currentTimeMillis = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = sdf.format(new Date(currentTimeMillis));
        req.setAttribute("currentTime", formattedDate);
        String requestData = String.format("x=%s,y=%s,r=%s,result=%s,time=%s,currentTime=%s", x, y, r,req.getAttribute("result"),req.getAttribute("time"),req.getAttribute("currentTime"));
        requests.add(requestData);
        context.setAttribute("requests",requests);
        RequestDispatcher rd = req.getRequestDispatcher("/result.jsp");
        rd.forward(req,res);
    }
    private static boolean check(String x1, String y1, String r1){
        int x = Integer.parseInt(x1);
        float y = Float.parseFloat(y1);
        float r = Float.parseFloat(r1);
        if ((y>=0 && x>=0 && y<=-x + r) || (x<=0 && x>=-r && y<=0 && y>=-r*0.5) || (x>=0 && y<=0 && x*x+y*y<r*r*0.25) ){
            return true;
        }else{
            return false;
        }
    }
}
