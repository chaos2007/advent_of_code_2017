use std::collections::HashMap;
use std::fs::File;
use std::io::prelude::*;

#[derive(Debug, PartialEq, Clone)]
struct Node {
    name: String,
    weight: i32,
    children: Vec<String>,
    parent: String
}

fn create_node( words: String ) -> Node {
    let res: Vec<String> = words.split(" ").map(|s| s.to_string()).collect();
    let name = res[0].to_string();
    let x: &[_] = &['(', ')'];
    let weight = res[1].trim_matches(x).parse::<i32>().unwrap();
    let mut children: Vec<String> = vec![];
    if res.len() > 3  {
        children = (res[3..]).iter().map(|s| s.trim_matches(',').to_string()).collect();
    }
    return Node {name: name, children: children, weight: weight, parent: "".to_string()};
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
fn get_parent_node( nodes_string: String ) -> String {
    let mut grid = build_tree( nodes_string );
    let mut first = "".to_string();
    for (name, number) in grid.iter() {
        first = name.to_string();
    }
    loop {
        if let Some(node) = grid.get_mut(&first) {
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

fn get_new_weight( nodes_string: String ) -> i32 {
    let mut grid = build_tree( nodes_string.to_string() );
    let parent = get_parent_node( nodes_string.to_string() );
    return 0;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_creating_node_no_children() {
        let expected = Node {name: "snslv".to_string(), weight: 48, children: vec![], parent: "".to_string()};
        assert_eq!(expected, create_node("snslv (48)".to_string()))
    }

    #[test]
    fn test_creating_node_with_children() {
        let expected = Node {name: "mypyemv".to_string(), weight: 1058, parent: "".to_string(), children: vec!["tdssotr".to_string(), "pebnvks".to_string(), "zaulju".to_string()] };
        assert_eq!(expected, create_node("mypyemv (1058) -> tdssotr, pebnvks, zaulju".to_string()))
    }

    #[test]
    fn test_getting_simple_parent() {
        let mut f = File::open("small_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        assert_eq!("tknk".to_string(), get_parent_node(contents));
    }

    #[test]
    fn test_getting_complicated_parent() {
        let mut f = File::open("puzzle_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        assert_eq!("vmpywg".to_string(), get_parent_node(contents));
    }

    #[test]
    fn test_getting_new_weight_for_wrong_program() {
        let mut f = File::open("small_input.txt").expect("file not found");
        let mut contents = String::new();
        f.read_to_string(&mut contents);
        assert_eq!(60, get_new_weight(contents));
    }
}

