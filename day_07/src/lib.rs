use std::collections::HashMap;
use std::fs::File;
use std::io::prelude::*;

#[derive(Debug, PartialEq, Clone)]
struct Node {
    name: String,
    weight: i32,
    total_weight: i32,
    children: Vec<String>,
    parent: String
}

fn create_node( line: String ) -> Node {
    let words: Vec<String> = line.split(" ").map(|s| s.to_string()).collect();
    let name = words[0].to_string();
    let x: &[_] = &['(', ')'];
    let weight = words[1].trim_matches(x).parse::<i32>().unwrap();
    let mut children: Vec<String> = vec![];
    if words.len() > 3  {
        children = (words[3..]).iter().map(|s| s.trim_matches(',').to_string()).collect();
    }
    return Node {name: name, children: children, weight: weight, parent: "".to_string(), total_weight: 0};
} 

fn build_tree( nodes_string: String ) -> HashMap<String, Node> { 
    //Create Map
    let mut res: HashMap<String, Node> = HashMap::new();

    //Throw every node in map.
    let lines: Vec<String> = nodes_string.split("\n").map(|s| s.to_string()).collect();
    for line in lines.iter() {
        let node = create_node(line.to_string());
        res.insert(node.name.to_string(), node);
    }
    
    let mut res2 = res.clone();
    //Build up parent tree.
    for (name, node) in & mut res {
        for child in &(node.children) {
            match res2.get_mut(child) {
                Some(element) => element.parent = name.to_string(),
                None => println!("{} is not there..", child)
            }
        }
    }
    return res2;
}
fn get_parent_node( grid: & HashMap<String, Node> ) -> String {
    let mut first = "".to_string();
    for (name, number) in grid.iter() {
        first = name.to_string();
        break;
    }
    loop {
        if let Some(node) = grid.get(&first) {
            if node.parent == "".to_string() {
                return first;
            }
            first = node.parent.to_string();
        }
        else {
            break;
        }

    }
    return "".to_string();
}

fn fill_in_weights( grid: HashMap<String, Node> ) -> HashMap<String, Node> {
    let mut res = grid.clone();
    let parent = get_parent_node( &grid );
    fill_in_weights_recurse( &grid, &mut res, parent);
    return res;
}

fn fill_in_weights_recurse( grid: &HashMap<String, Node>, mut_grid: &mut HashMap<String, Node>, current_node: String ) {
    let mut sum = 0;
    if let Some(node) = grid.get(&current_node) {
        for child in &(node.children) {
            fill_in_weights_recurse( grid, mut_grid, child.to_string() );
            if let Some(child_node) = mut_grid.get(&child.to_string()) {
                sum += child_node.total_weight;
            }
        }
        sum += node.weight;
    }
    if let Some(node) = mut_grid.get_mut(&current_node) {
        node.total_weight = sum;
    }
    return;
}
fn get_new_weight( nodes_string: String ) -> i32 {
    let mut grid = build_tree( nodes_string.to_string() );
    let parent = get_parent_node( &grid );
    let calculated_grid = fill_in_weights( grid );

    //Determine incorrect_weight_offset
    if let Some(node) = calculated_grid.get(&parent) {
        let weights : Vec<i32> = node.clone().children.into_iter().map(|child| {
            if let Some(child_node) = calculated_grid.get(&child.to_string()) {
                child_node.total_weight
            } else {
                0
            }
        }).collect();
        println!("Weights {:?}", weights);
        // let correct = weights.groupBy(identity).maxBy(_._2.size)._1;
        // println!("Correct {:?}", correct);
        // for child in &(node.children) {
        //     if let Some(child_node) = calculated_grid.get(&child.to_string()) {
        //         println!("Name: {} Weight: {}", child_node.name, child_node.total_weight);
        //     }
        // }
    }
    return 0;
}
fn get_new_weight_recurse( grid: &HashMap<String, Node>, offset: i32, current_node: String ) -> i32 {
    //Are all children weights equal.  If so, return your own weight + offset.
    //If not recall function on child that has the wrong offset.
    return 0;
}

fn get_correct_and_incorrect_weights( numbers: &Vec<i32> ) -> (i32, i32) {
    let mut count : HashMap<i32,i32> = HashMap::new();
    {
        let entry = count.entry(0).or_insert(0);
        *entry += 1;
    }
    println!("{:?}", count );
    return (0, 0);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_creating_node_no_children() {
        let expected = Node {name: "snslv".to_string(), weight: 48, children: vec![], parent: "".to_string(), total_weight: 0};
        assert_eq!(expected, create_node("snslv (48)".to_string()))
    }

    #[test]
    fn test_creating_node_with_children() {
        let expected = Node {name: "mypyemv".to_string(), weight: 1058, total_weight: 0, parent: "".to_string(), children: vec!["tdssotr".to_string(), "pebnvks".to_string(), "zaulju".to_string()] };
        assert_eq!(expected, create_node("mypyemv (1058) -> tdssotr, pebnvks, zaulju".to_string()))
    }

    #[test]
    fn test_getting_simple_parent() {
        let mut f = File::open("small_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        let grid = build_tree( contents );
        let parent = get_parent_node( &grid );
        assert_eq!("tknk".to_string(), parent);
    }

    #[test]
    fn test_getting_complicated_parent() {
        let mut f = File::open("puzzle_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        let grid = build_tree( contents );
        let parent = get_parent_node( &grid );
        assert_eq!("vmpywg".to_string(), parent);
    }

    #[test]
    fn test_filling_in_weights() {
        let mut f = File::open("small_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        let grid = build_tree( contents );
        let calculated_grid = fill_in_weights( grid );
        match calculated_grid.get(&"ugml".to_string()) {
            Some(element) => assert_eq!(251, element.total_weight),
            None => panic!("should_exist")
        }
        match calculated_grid.get(&"padx".to_string()) {
            Some(element) => assert_eq!(243, element.total_weight),
            None => panic!("should_exist")
        }
        match calculated_grid.get(&"fwft".to_string()) {
            Some(element) => assert_eq!(243, element.total_weight),
            None => panic!("should_exist")
        }
    }

    #[test]
    fn test_finding_wrong_weight() {
        let mut f = File::open("small_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        let new_weight = get_new_weight( contents );
        //assert_eq!(60, new_weight);
    }

    #[test]
    fn test_filling_in_weights_large() {
        let mut f = File::open("puzzle_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        let grid = build_tree( contents );
        let calculated_grid = fill_in_weights( grid );
    }

    #[test]
    fn test_finding_correct_incorrect_weight() {
        let numbers = vec![153, 153, 148];
        let (correct, incorrect) = get_correct_and_incorrect_weights(&numbers);
        assert_eq!(correct, 153);
        assert_eq!(incorrect, 148);
    }
}

