; SQL injection for strings after /* sql */ comment
; This pattern enables SQL syntax highlighting in JavaScript/TypeScript strings
; that are preceded by a /* sql */ comment.
;
; Example usage:
;   /* sql */
;   const query = "SELECT * FROM users WHERE id = 1";
;
((comment) @_comment
  ; Match comments that contain "sql" between /* and */ (with optional spaces)
  (#match? @_comment "^/\\* *sql *\\*/$")
  ; The dot (.) ensures immediate adjacency - the string MUST be the very next
  ; sibling node after the comment, with no other nodes in between.
  ; Without this, any string later in the scope would match.
  .
  ; Match either a regular string or a template string (backticks)
  [(string (string_fragment) @injection.content)
   (template_string (string_fragment) @injection.content)]
  ; Tell tree-sitter to treat the matched content as SQL for highlighting
  (#set! injection.language "sql"))
