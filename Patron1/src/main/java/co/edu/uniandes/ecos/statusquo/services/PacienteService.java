/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.uniandes.ecos.statusquo.services;

import co.edu.uniandes.ecos.statusquo.persistence.dao.PacienteDAO;
import co.edu.uniandes.ecos.statusquo.persistence.entities.Paciente;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.ws.rs.GET;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.json.simple.JSONObject;

/**
 *
 * @author Alvaro
 */
@Stateless
@Path("/paciente")
@Produces(MediaType.APPLICATION_JSON)
public class PacienteService {

    private PacienteDAO dao;

    @PostConstruct
    public void init() {

        try {
            final Context context = new InitialContext();
            dao = (PacienteDAO) context.lookup("java:global/Experimento-1-1/PacienteDAO");
        } catch (ClassCastException | NamingException ex) {
            ex.printStackTrace(System.out);
        }
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAll() {
        List<Paciente> pacientes;
        try {
            pacientes = dao.findAll();
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            pacientes = new ArrayList<>();
        }
        return Response.status(200).header("Access-Control-Allow-Origin", "*").entity(pacientes).build();
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response crearPaciente(final Paciente paciente) {

        final JSONObject rta = new JSONObject();

        try {
            if (paciente != null) {
                if (paciente.getId() == null) {
                    dao.create(paciente);
                } else {
                    dao.edit(paciente);
                }
                rta.put("paciente_id", paciente.getId());
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }

        return Response.status(200).header("Access-Control-Allow-Origin", "*").entity(rta.toJSONString()).build();
    }

    @OPTIONS
    public Response cors(@javax.ws.rs.core.Context HttpHeaders requestHeaders) {
        return Response.status(200).header("Access-Control-Allow-Origin", "*").header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS").header("Access-Control-Allow-Headers", "AUTHORIZATION, content-type, accept").build();
    }
}
