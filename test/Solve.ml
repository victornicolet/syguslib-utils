open Syguslib
open Solvers

module Config : SolverSystemConfig = struct
  let cvc_binary_path () = FileUtil.which "cvc4"
  let dryadsynth_binary_path () = FileUtil.which "dryadsynth"
  let eusolver_binary_path () = FileUtil.which "eusolver"
  let using_cvc5 () = false
end

module Solver = LwtSolver (NoStat) (EmptyLog) (Config)

let test_lwt_solver input_file =
  Fmt.(pf stdout "SOLVE TEST %s .." input_file);
  let program = Parser.sexp_parse input_file in
  let opt_task, u = Solver.solve_commands ?solver_kind:(Some CVC) program in
  Lwt.wakeup u 0;
  match Lwt_main.run opt_task with
  | Some (RSuccess _) -> Fmt.(pf stdout "OK@.")
  | Some _ | None -> Fmt.(pf stdout "FAILED@.")
;;

test_lwt_solver "../../../test/inputs/positive/alist_sum.sl";
test_lwt_solver "../../../test/inputs/positive/bench_msshom2b1774.sl";
test_lwt_solver "../../../test/inputs/positive/bench_msshom931e5a.sl"
