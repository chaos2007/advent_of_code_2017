use std::collections::HashMap;

#[derive(Debug, PartialEq)]
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
    
    for (name, node) in &res {
        for child in &(node.children) {
            match res.get(child) {
                Some(element) => element.parent = name.to_string(),
                None => println!("{} is not there..", child)
            }
        }
    }
    return res;
}
fn get_parent_node( nodes_string: String ) -> String {
        /*
    while True:
        node = graph[key]
        if node["parent"] == None:
            return node
        key = node["parent"]*/
    return "".to_string();
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
        let sample_input = "pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)".to_string();
        assert_eq!("tknk".to_string(), get_parent_node(sample_input));
    }
}

