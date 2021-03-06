open Syguslib
open Solvers

module TestLog : Logger = struct
  let error f = Fmt.(pf stdout "%a@." f ())
  let debug f = Fmt.(pf stdout "%a@." f ())
  let verb f = Fmt.(pf stdout "%a@." f ())
  let log_file = "unknown"
  let verbose = true
  let log_queries = false
end

module Config : SolverSystemConfig = struct
  let cvc_binary_path () = "cvc4"
  let dryadsynth_binary_path () = "dryadsynth"
  let eusolver_binary_path () = "eusolver"
  let using_cvc5 () = false
end

(* Test the asynchronous solver using Lwt. *)
module LSolver = LwtSolver (NoStat) (TestLog) (Config)

let test_lwt_solver input_file =
  Fmt.(pf stdout "SOLVE TEST %s ..@." input_file);
  let program = Parser.sexp_parse input_file in
  let opt_task, u = LSolver.solve_commands ?solver_kind:(Some CVC) program in
  Lwt.wakeup u 0;
  match Lwt_main.run opt_task with
  | Some (RSuccess ((s, _, _, _) :: _)) ->
    Fmt.(pf stdout "Solution to: %s.@." s);
    Fmt.(pf stdout "OK@.")
  | Some _ | None -> Fmt.(pf stdout "FAILED@.")
;;

test_lwt_solver "../../../test/inputs/positive/alist_sum.sl";
test_lwt_solver "../../../test/inputs/positive/bench_msshom2b1774.sl";
test_lwt_solver "../../../test/inputs/positive/bench_msshom931e5a.sl"

(* Test the synchronous solver. *)
module SSolver = SyncSolver (NoStat) (TestLog) (Config)

let test_sync_solver input_file =
  Fmt.(pf stdout "SOLVE TEST %s ..@." input_file);
  let program = Parser.sexp_parse input_file in
  match SSolver.solve_commands ~solver_kind:CVC program with
  | RSuccess ((s, _, _, _) :: _) ->
    Fmt.(pf stdout "Solution to: %s.@." s);
    Fmt.(pf stdout "OK@.")
  | _ -> Fmt.(pf stdout "FAILED@.")
;;

test_sync_solver "../../../test/inputs/positive/alist_sum.sl";
test_sync_solver "../../../test/inputs/positive/bench_msshom2b1774.sl";
test_sync_solver "../../../test/inputs/positive/bench_msshom931e5a.sl"
