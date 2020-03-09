<?php

// Input: $result - the result you get from calling mysqli->query()
//		  which is either false or a mysqli_result object
// Output: either "No results returned" or a string consisting of
//		   html code to generate the table
function create_table_from_query_result($result) {
	if (!is_object($result)) {
		return "An error has occured";
	}
	else if ($result->num_rows < 1) {
		return "No results returned";
	}
	$rows = array();
	while ($resultrow = $result->fetch_assoc()) {
		$rows[] = $resultrow;
	}
	return create_table_from_row_array($rows);
}

// Input: $pds - a PDO statement
// Output: either "No results returned" or a string consisting of
//		   html code to generate the table
function create_table_from_pdo_result($pds) {
	if (!$pds) {
		return "An error has occured";
	}
	$rows = pdoFetchAllAssoc($pds);
	if (count($rows) < 1) {
		return "No results returned";
	}
	return create_table_from_row_array($rows);
}

// Input: $row_arr - an array of result rows - cannot be empty
// Output: a string consisting of html code to generate the table
function create_table_from_row_array($row_arr) {
	$output = "<table><tr>";
	$headings = array_keys($row_arr[0]);
	foreach ($headings as $heading) {
		$output .= "<th>".$heading."</th>";
	}
	$output .= "</tr>";
	foreach ($row_arr as $row) {
		$output .= "<tr>";
		
		foreach ($row as $field) {
			if (is_null($field)) {
				$output .= "<td>NULL</td>";
			}
			else {
				$output .= "<td>".$field."</td>";
			}
		}
		
		$output .= "</tr>";
	}
	$output .= "</table>";
	return $output;
}

?>